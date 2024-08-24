namespace lab
{
  static class ProgramAction
  {
    public const string ADD = "add";
    public const string DISPLAY = "display";

    public static List<string> ACTIONS = new()
        {
            ADD, DISPLAY
        };
  }
  class Program
  {
    static void Main()
    {
      using CompanyContext companyContext = new();

      string action = Choose("Wybierz, co chcesz zrobić", ProgramAction.ACTIONS);

      switch (action)
      {
        case ProgramAction.ADD:
          AddCompany(companyContext);
          break;
        case ProgramAction.DISPLAY:
          DisplayCompanies(companyContext);
          break;
      }
    }

    private static void AddCompany(CompanyContext companyContext)
    {
      while (true)
      {
        string type = Choose("Wprowadź typ firmy, którą chcesz dodać", CompanyType.ALL_TYPES);

        string companyName = Input("Podaj nazwę firmy");
        string street = Input("Podaj ulicę");
        string city = Input("Podaj miasto");
        string postalCode = Input("Podaj kod pocztowy (zip)");

        switch (type)
        {
          case CompanyType.CUSTOMER:
            companyContext.Companies.Add(CreateCustomer(companyName, street, city, postalCode));
            companyContext.SaveChanges();
            return;
          case CompanyType.SUPPLIER:
            companyContext.Companies.Add(CreateSupplier(companyName, street, city, postalCode));
            companyContext.SaveChanges();
            return;
        }
      }
    }

    private static Supplier CreateSupplier(string companyName, string street, string city, string postalCode)
    {
      string bankAccount = Input("Podaj numer konta bankowego");

      return new Supplier
      {
        CompanyName = companyName,
        Street = street,
        City = city,
        ZipCode = postalCode,
        BankAccountNumber = bankAccount
      };
    }

    private static Customer CreateCustomer(string companyName, string street, string city, string postalCode)
    {
      int discount = int.Parse(Input("Podaj wartość zniżki (%)"));

      return new Customer
      {
        CompanyName = companyName,
        Street = street,
        City = city,
        ZipCode = postalCode,
        Discount = discount
      };
    }

    private static void DisplayCompanies(CompanyContext companyContext)
    {
      List<string> types = new();
      types.AddRange(CompanyType.ALL_TYPES);
      types.Add("all");

      string type = Choose("Wprowadź typ firm, które chcesz wypisać", types);

      switch (type)
      {
        case "all":
          DisplayAllCompanies(companyContext);
          break;
        case CompanyType.SUPPLIER:
          DisplaySuppliers(companyContext);
          break;
        case CompanyType.CUSTOMER:
          DisplayCustomers(companyContext);
          break;
      }
    }

    private static void DisplaySuppliers(CompanyContext companyContext)
    {
      Console.WriteLine("Lista wszystkich dostawców (firm):");
      foreach (Supplier supplier in companyContext.Suppliers)
      {
        Console.WriteLine(supplier);
      }
    }

    private static void DisplayCustomers(CompanyContext companyContext)
    {
      Console.WriteLine("Lista wszystkich klientów (firm):");
      foreach (Customer customer in companyContext.Customers)
      {
        Console.WriteLine(customer);
      }
    }

    private static void DisplayAllCompanies(CompanyContext companyContext)
    {
      Console.WriteLine("Lista wszystkich klientów (firm):");
      foreach (Company company in companyContext.Companies)
      {
        Console.WriteLine(company);
      }
    }

    private static string Input(string text)
    {
      Console.Write($"{text}\n>>> ");
      string? input = Console.ReadLine();
      if (input == null) return String.Empty;
      return input.Trim();
    }

    public static string Choose(string text, List<string> choices)
    {
      Console.WriteLine(text);
      Console.WriteLine("Możliwy wybór:");
      foreach (string choice in choices) Console.WriteLine($"\t- {choice}");
      Console.WriteLine("Aby wyjść, wpisz 'exit'");

      while (true)
      {
        string choice = Input("");

        foreach (string possibleChoice in choices)
        {
          if (choice.Equals(possibleChoice)) return choice;
        }

        if (choice.Equals("exit"))
        {
          Console.WriteLine("To dzisiaj na tyle, dzięki za współpracę");
          return string.Empty;
        }

        Console.WriteLine("Polecenie nie zostało rozpoznane, spróbuj jeszcze raz\n");
      }
    }
  }
}