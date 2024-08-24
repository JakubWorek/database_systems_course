using System;
public class Program{
  static void Main(){
    Console.WriteLine("Podaj nazwę produktu");
    String prodName = Console.ReadLine();

    ProdContext prodContext = new ProdContext();
    Product product = new Product { ProductName = prodName };
    prodContext.Products.Add(product);
    prodContext.SaveChanges();

    Console.WriteLine("Poniżej lista produktów zarejestrowanych w naszej bazie danych");
    var query = from prod in prodContext.Products
                select prod.ProductName;

    foreach (var pName in query){
      Console.WriteLine(pName);
    }
  }
}
