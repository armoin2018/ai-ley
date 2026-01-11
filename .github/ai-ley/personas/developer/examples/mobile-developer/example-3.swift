// ContentView.swift - Main SwiftUI app
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var cartManager = CartManager()
    
    var body: some View {
        NavigationView {
            ProductListView()
                .navigationTitle("Products")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: CartView()) {
                            HStack {
                                Image(systemName: "cart")
                                if cartManager.itemCount > 0 {
                                    Text("\(cartManager.itemCount)")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .background(Circle().fill(Color.red).frame(width: 20, height: 20))
                                }
                            }
                        }
                    }
                }
        }
        .environmentObject(cartManager)
    }
}

// ProductListView.swift - Product list with search and filtering
struct ProductListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>
    
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    @State private var isLoading = false
    
    private let categories = ["All", "Electronics", "Clothing", "Books"]
    
    var filteredProducts: [Product] {
        products.filter { product in
            let matchesSearch = searchText.isEmpty || 
                product.name?.localizedCaseInsensitiveContains(searchText) ?? false
            let matchesCategory = selectedCategory == "All" || 
                product.category == selectedCategory
            return matchesSearch && matchesCategory
        }
    }
    
    var body: some View {
        VStack {
            // Search and filter controls
            VStack(spacing: 10) {
                SearchBar(text: $searchText)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(categories, id: \.self) { category in
                            CategoryChip(
                                title: category,
                                isSelected: selectedCategory == category
                            ) {
                                selectedCategory = category
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical, 10)
            
            // Products grid
            if isLoading {
                Spacer()
                ProgressView("Loading products...")
                Spacer()
            } else {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(filteredProducts, id: \.objectID) { product in
                        NavigationLink(
                            destination: ProductDetailView(product: product)
                        ) {
                            ProductCardView(product: product)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
        .refreshable {
            await loadProducts()
        }
        .onAppear {
            if products.isEmpty {
                Task {
                    await loadProducts()
                }
            }
        }
    }
    
    private func loadProducts() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await URLSession.shared.data(from: URL(string: "https://api.example.com/products")!)
            let productData = try JSONDecoder().decode([ProductData].self, from: response.0)
            
            await MainActor.run {
                // Clear existing products
                for product in products {
                    viewContext.delete(product)
                }
                
                // Add new products
                for data in productData {
                    let product = Product(context: viewContext)
                    product.id = data.id
                    product.name = data.name
                    product.price = data.price
                    product.imageURL = data.imageUrl
                    product.productDescription = data.description
                    product.category = data.category
                }
                
                try? viewContext.save()
            }
        } catch {
            print("Failed to load products: \(error)")
        }
    }
}

// ProductCardView.swift - Individual product card
struct ProductCardView: View {
    let product: Product
    @EnvironmentObject var cartManager: CartManager
    @State private var showAddedAnimation = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Product image
            AsyncImage(url: URL(string: product.imageURL ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
            .frame(height: 120)
            .clipped()
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name ?? "")
                    .font(.headline)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                Text(product.productDescription ?? "")
                    .font(.caption)
                    .lineLimit(3)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                // Add to cart button
                Button(action: addToCart) {
                    HStack {
                        Image(systemName: showAddedAnimation ? "checkmark" : "plus")
                        Text(showAddedAnimation ? "Added!" : "Add to Cart")
                    }
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(showAddedAnimation ? Color.green : Color.blue)
                    )
                }
                .disabled(showAddedAnimation)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
    }
    
    private func addToCart() {
        cartManager.addItem(product)
        
        withAnimation(.easeInOut(duration: 0.3)) {
            showAddedAnimation = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut(duration: 0.3)) {
                showAddedAnimation = false
            }
        }
        
        // Haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
}

// CartManager.swift - Cart state management
import Foundation
import Combine

class CartManager: ObservableObject {
    @Published var items: [CartItem] = []
    
    var itemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
    
    var totalPrice: Double {
        items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    
    func addItem(_ product: Product) {
        if let existingIndex = items.firstIndex(where: { $0.product.objectID == product.objectID }) {
            items[existingIndex].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
    }
    
    func removeItem(_ product: Product) {
        items.removeAll { $0.product.objectID == product.objectID }
    }
    
    func updateQuantity(for product: Product, quantity: Int) {
        if let index = items.firstIndex(where: { $0.product.objectID == product.objectID }) {
            if quantity <= 0 {
                items.remove(at: index)
            } else {
                items[index].quantity = quantity
            }
        }
    }
    
    func clearCart() {
        items.removeAll()
    }
}

struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
}