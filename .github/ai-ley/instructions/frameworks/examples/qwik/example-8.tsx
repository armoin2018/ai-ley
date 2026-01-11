import { 
  component$, 
  useSignal, 
  useVisibleTask$, 
  useTask$,
  $,
  Slot 
} from '@builder.io/qwik';
import { isServer } from '@builder.io/qwik/build';

// Lazy loading with intersection observer
export const LazyImage = component$<{
  src: string;
  alt: string;
  width?: number;
  height?: number;
}>((props) => {
  const imageRef = useSignal<HTMLImageElement>();
  const isVisible = useSignal(false);
  const isLoaded = useSignal(false);
  
  // Client-side intersection observer
  useVisibleTask$(() => {
    if (!imageRef.value) return;
    
    const observer = new IntersectionObserver(
      (entries) => {
        if (entries[0].isIntersecting) {
          isVisible.value = true;
          observer.disconnect();
        }
      },
      { threshold: 0.1 }
    );
    
    observer.observe(imageRef.value);
    
    return () => observer.disconnect();
  });
  
  const handleLoad = $(() => {
    isLoaded.value = true;
  });
  
  return (
    <div 
      ref={imageRef}
      class="lazy-image-container"
      style={{
        width: props.width ? `${props.width}px` : 'auto',
        height: props.height ? `${props.height}px` : 'auto',
      }}
    >
      {isVisible.value && (
        <img
          src={props.src}
          alt={props.alt}
          loading="lazy"
          onLoad$={handleLoad}
          class={`lazy-image ${isLoaded.value ? 'loaded' : 'loading'}`}
          width={props.width}
          height={props.height}
        />
      )}
      
      {!isLoaded.value && isVisible.value && (
        <div class="image-placeholder">Loading...</div>
      )}
    </div>
  );
});

// Infinite scroll implementation
export const InfiniteScroll = component$<{
  items: any[];
  loadMore: () => Promise<void>;
  hasMore: boolean;
}>((props) => {
  const loadingRef = useSignal<HTMLDivElement>();
  const isLoading = useSignal(false);
  
  const handleLoadMore = $(async () => {
    if (isLoading.value || !props.hasMore) return;
    
    isLoading.value = true;
    try {
      await props.loadMore();
    } finally {
      isLoading.value = false;
    }
  });
  
  useVisibleTask$(() => {
    if (!loadingRef.value) return;
    
    const observer = new IntersectionObserver(
      (entries) => {
        if (entries[0].isIntersecting && props.hasMore) {
          handleLoadMore();
        }
      },
      { threshold: 0.1 }
    );
    
    observer.observe(loadingRef.value);
    
    return () => observer.disconnect();
  });
  
  return (
    <div class="infinite-scroll">
      <Slot />
      
      {props.hasMore && (
        <div 
          ref={loadingRef}
          class="loading-trigger"
        >
          {isLoading.value ? 'Loading more...' : 'Load more'}
        </div>
      )}
    </div>
  );
});

// Virtual scrolling for large lists
export const VirtualList = component$<{
  items: any[];
  itemHeight: number;
  containerHeight: number;
  renderItem: (item: any, index: number) => any;
}>((props) => {
  const containerRef = useSignal<HTMLDivElement>();
  const scrollTop = useSignal(0);
  
  const handleScroll = $((event: Event) => {
    const target = event.target as HTMLDivElement;
    scrollTop.value = target.scrollTop;
  });
  
  // Calculate visible items
  const startIndex = Math.floor(scrollTop.value / props.itemHeight);
  const endIndex = Math.min(
    startIndex + Math.ceil(props.containerHeight / props.itemHeight) + 1,
    props.items.length
  );
  
  const visibleItems = props.items.slice(startIndex, endIndex);
  const offsetY = startIndex * props.itemHeight;
  
  return (
    <div
      ref={containerRef}
      class="virtual-list"
      style={{
        height: `${props.containerHeight}px`,
        overflow: 'auto'
      }}
      onScroll$={handleScroll}
    >
      <div
        style={{
          height: `${props.items.length * props.itemHeight}px`,
          position: 'relative'
        }}
      >
        <div
          style={{
            transform: `translateY(${offsetY}px)`,
            position: 'absolute',
            top: 0,
            left: 0,
            right: 0
          }}
        >
          {visibleItems.map((item, index) => (
            <div
              key={startIndex + index}
              style={{ height: `${props.itemHeight}px` }}
            >
              {props.renderItem(item, startIndex + index)}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
});