using Microsoft.EntityFrameworkCore;

namespace lab{
  internal class CompanyContext : DbContext{
    public DbSet<Company>? Companies { get; set; }
    public DbSet<Supplier>? Suppliers { get; set; }
    public DbSet<Customer>? Customers { get; set; }
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder){
      base.OnConfiguring(optionsBuilder);
      optionsBuilder.UseSqlite("Datasource=CompaniesDatabase.db");
    }
  }
}