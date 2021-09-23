package migration;

import org.flywaydb.core.Flyway;

public class Migration {
	public static void main(String[] args) {
		Flyway flyway = new Flyway();
		flyway.setDataSource("jdbc:postgresql://localhost:5432/new_vk_api?currentSchema=public",
				"postgres", "3242091046");
		flyway.repair();
		flyway.migrate();
	}
}
