using DevExpress.ExpressApp.EFCore.Updating;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using DevExpress.Persistent.BaseImpl.EF.PermissionPolicy;
using DevExpress.Persistent.BaseImpl.EF;
using DevExpress.ExpressApp.Design;
using DevExpress.ExpressApp.EFCore.DesignTime;

namespace Park_Sistemi.Module.BusinessObjects;

// This code allows our Model Editor to get relevant EF Core metadata at design time.
// For details, please refer to https://supportcenter.devexpress.com/ticket/details/t933891.
public class Park_SistemiContextInitializer : DbContextTypesInfoInitializerBase {
	protected override DbContext CreateDbContext() {
		var optionsBuilder = new DbContextOptionsBuilder<Park_SistemiEFCoreDbContext>()
            .UseSqlServer(";")
            .UseChangeTrackingProxies()
            .UseObjectSpaceLinkProxies();
        return new Park_SistemiEFCoreDbContext(optionsBuilder.Options);
	}
}
//This factory creates DbContext for design-time services. For example, it is required for database migration.
public class Park_SistemiDesignTimeDbContextFactory : IDesignTimeDbContextFactory<Park_SistemiEFCoreDbContext>
{
    public Park_SistemiEFCoreDbContext CreateDbContext(string[] args)
    {
        // Throw new InvalidOperationException("Make sure that the database connection string and connection provider are correct. After that, uncomment the code below and remove this exception.");
        var optionsBuilder = new DbContextOptionsBuilder<Park_SistemiEFCoreDbContext>();
        optionsBuilder.UseSqlServer("Integrated Security=SSPI;Pooling=false;Data Source=(localdb)\\mssqllocaldb;Initial Catalog=Park_Sistemi");
        // Automatically implements the INotifyPropertyChanged interface in the business objects
        optionsBuilder.UseChangeTrackingProxies();
        optionsBuilder.UseObjectSpaceLinkProxies();
        return new Park_SistemiEFCoreDbContext(optionsBuilder.Options);
    }
}
[TypesInfoInitializer(typeof(Park_SistemiContextInitializer))]
public class Park_SistemiEFCoreDbContext : DbContext {
	public Park_SistemiEFCoreDbContext(DbContextOptions<Park_SistemiEFCoreDbContext> options) : base(options) {

	}
    //public DbSet<ModuleInfo> ModulesInfo { get; set; }
    public DbSet<Vale> Vale { get; set; }
    protected override void OnModelCreating(ModelBuilder modelBuilder) {
        base.OnModelCreating(modelBuilder);
        modelBuilder.HasChangeTrackingStrategy(ChangeTrackingStrategy.ChangingAndChangedNotificationsWithOriginalValues);
        modelBuilder.UsePropertyAccessMode(PropertyAccessMode.PreferFieldDuringConstruction);
    }
}
