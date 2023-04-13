package hkmu.comps380f.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import static org.springframework.security.config.Customizer.withDefaults;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http)
            throws Exception {
        http
                .authorizeHttpRequests(authorize -> authorize

                        .requestMatchers("/user/**").permitAll()
                        .requestMatchers("/user/delete/**").hasRole("ADMIN")

                        .requestMatchers("/Books/*/delete/**").hasRole("ADMIN")
                        .requestMatchers("/Books/delete/**").hasRole("ADMIN")
//                        .requestMatchers("/Books/home").permitAll()
                        .requestMatchers("/Books/list").hasRole("ADMIN")
//                        .requestMatchers("/Books/list/user/**").hasRole("ADMIN")
                        .requestMatchers("/Books/create").hasAnyRole("ADMIN","USER")
                        .anyRequest().permitAll()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .failureUrl("/login?error")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                )
                .rememberMe(remember -> remember
                        .key("uniqueAndSecret")
                        .tokenValiditySeconds(86400)
                )
                .httpBasic(withDefaults());
        return http.build();
    }
}

