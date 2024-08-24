using Microsoft.EntityFrameworkCore;

namespace lab{
  internal class ProdContext: DbContext{
    public DbSet<Product> Products { get; set; }
    public DbSet<Supplier> Suppliers { get; set; }
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder){
      base.OnConfiguring(optionsBuilder);
      optionsBuilder.UseSqlite("Datasource=MyProductDatabase");
    }
  }
}