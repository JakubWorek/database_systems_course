namespace lab{
  internal abstract class Company{
    public int CompanyID { get; set; }
    public string CompanyName { get; set; } = String.Empty;
    public string Street { get; set; } = String.Empty;
    public string City { get; set; } = String.Empty;
    public string ZipCode { get; set; } = String.Empty;
    public override string ToString(){
      return $"[{CompanyID}] {CompanyName}";
    }
  }
}