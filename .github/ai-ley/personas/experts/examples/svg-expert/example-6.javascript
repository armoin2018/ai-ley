class SVGChart {
  constructor(container, data) {
    this.container = container;
    this.data = data;
    this.width = 500;
    this.height = 300;
    this.margin = { top: 20, right: 20, bottom: 40, left: 40 };
    
    this.init();
  }
  
  init() {
    this.svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    this.svg.setAttribute('viewBox', `0 0 ${this.width} ${this.height}`);
    this.svg.setAttribute('role', 'img');
    this.svg.setAttribute('aria-labelledby', 'chart-title');
    
    // Add title for accessibility
    const title = document.createElementNS('http://www.w3.org/2000/svg', 'title');
    title.id = 'chart-title';
    title.textContent = 'Data Chart';
    this.svg.appendChild(title);
    
    this.container.appendChild(this.svg);
    this.render();
  }
  
  render() {
    const chartArea = this.createChartArea();
    this.drawBars(chartArea);
    this.drawAxes(chartArea);
  }
  
  createChartArea() {
    const g = document.createElementNS('http://www.w3.org/2000/svg', 'g');
    g.setAttribute('transform', `translate(${this.margin.left}, ${this.margin.top})`);
    this.svg.appendChild(g);
    return g;
  }
  
  drawBars(container) {
    const barWidth = (this.width - this.margin.left - this.margin.right) / this.data.length;
    const maxValue = Math.max(...this.data.map(d => d.value));
    
    this.data.forEach((d, i) => {
      const bar = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
      const barHeight = (d.value / maxValue) * (this.height - this.margin.top - this.margin.bottom);
      
      bar.setAttribute('x', i * barWidth);
      bar.setAttribute('y', this.height - this.margin.top - this.margin.bottom - barHeight);
      bar.setAttribute('width', barWidth - 2);
      bar.setAttribute('height', 0);
      bar.setAttribute('fill', '#3498db');
      bar.setAttribute('role', 'graphics-symbol');
      bar.setAttribute('aria-label', `${d.label}: ${d.value}`);
      
      // Animate bar height
      bar.animate([
        { height: '0' },
        { height: `${barHeight}px` }
      ], {
        duration: 1000,
        delay: i * 100,
        easing: 'ease-out',
        fill: 'forwards'
      });
      
      container.appendChild(bar);
    });
  }
  
  updateData(newData) {
    this.data = newData;
    this.svg.innerHTML = '';
    this.render();
  }
}