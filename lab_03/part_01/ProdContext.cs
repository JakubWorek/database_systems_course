using Microsoft.EntityFrameworkCore;
public class ProdContext: DbContext{
  public DbSet<Product> Products { get; set; }

  protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder){
    base.OnConfiguring(optionsBuilder);
    optionsBuilder.UseSqlite("Datasource=MyProductDatabase");
  }

}
