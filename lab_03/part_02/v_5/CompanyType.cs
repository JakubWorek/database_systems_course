namespace lab{
  internal static class CompanyType{
    public const string CUSTOMER = "customer";
    public const string SUPPLIER = "supplier";
    public static List<string> ALL_TYPES = new(){
      CUSTOMER,
      SUPPLIER
    };
  }
}