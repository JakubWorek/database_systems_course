using Microsoft.EntityFrameworkCore;

namespace lab{
  internal class ProdContext: DbContext{
    public DbSet<Product> Products { get; set; }
    public DbSet<Invoice> Invoices { get; set; }
    public DbSet<InvoiceItem> InvoiceItems { get; set; }
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder){
      base.OnConfiguring(optionsBuilder);
      optionsBuilder.UseSqlite("Datasource=MyProductDatabase");
    }
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
      modelBuilder.Entity<InvoiceItem>()
          .HasKey(x => new { x.InvoiceNumber, x.ProductID });
    }
  }
}