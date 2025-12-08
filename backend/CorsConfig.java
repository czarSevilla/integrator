package mx.posicionsatelital.backend.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfig {

	@Bean
	WebMvcConfigurer corsConfigurer() {
		return new WebMvcConfigurer() {
			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry.addMapping("/**")
					// Permitir orígenes de desarrollo y producción
					// Usar allowedOriginPatterns cuando allowCredentials es true
					.allowedOriginPatterns(
						"{{ APP_URL }}",
						"{{ KEYCLOAK_URL }}"
					)
					.allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH")
					.allowedHeaders("*")
					.exposedHeaders("*")
					.allowCredentials(true)
					.maxAge(3600); // Cache preflight requests por 1 hora
			}
		};
	}
}