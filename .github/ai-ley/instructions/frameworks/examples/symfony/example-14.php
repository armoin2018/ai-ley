#[ApiResource(
      operations: [
          new Get(),
          new GetCollection(),
          new Post(),
          new Put(),
          new Delete()
      ]
  )]
  class Product {}