// Real-time stream processing with windowing
public class OrderAnalyticsStream {
    
    public static void main(String[] args) {
        Properties props = new Properties();
        props.put(StreamsConfig.APPLICATION_ID_CONFIG, "order-analytics");
        props.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, "kafka:9092");
        props.put(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, Serdes.String().getClass());
        props.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, SpecificAvroSerde.class);
        props.put(AbstractKafkaSchemaSerDeConfig.SCHEMA_REGISTRY_URL_CONFIG, "http://schema-registry:8081");
        
        // Exactly-once processing
        props.put(StreamsConfig.PROCESSING_GUARANTEE_CONFIG, StreamsConfig.EXACTLY_ONCE_V2);
        
        StreamsBuilder builder = new StreamsBuilder();
        
        KStream<String, Order> orders = builder.stream("orders");
        
        // Real-time order analytics with windowing
        orders
            .filter((key, order) -> order.getStatus().equals("COMPLETED"))
            .groupBy((key, order) -> order.getCustomerId().toString())
            .windowedBy(TimeWindows.of(Duration.ofMinutes(5)))
            .aggregate(
                () -> new CustomerMetrics(),
                (key, order, metrics) -> {
                    metrics.incrementOrderCount();
                    metrics.addRevenue(order.getTotal());
                    return metrics;
                },
                Materialized.with(Serdes.String(), customerMetricsSerde())
            )
            .toStream()
            .to("customer-metrics");
        
        KafkaStreams streams = new KafkaStreams(builder.build(), props);
        streams.start();
        
        // Graceful shutdown
        Runtime.getRuntime().addShutdownHook(new Thread(streams::close));
    }
}