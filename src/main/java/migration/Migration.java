package migration;

import org.flywaydb.core.Flyway;

public class Migration {
	public static void main(String[] args) {
		Flyway flyway = new Flyway();
		flyway.setDataSource("db_url?currentSchema=public",
				"user", "pasword");
		flyway.repair();
		flyway.migrate();
	}
}
