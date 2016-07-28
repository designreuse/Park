package org.k.photohost.config;

import org.apache.commons.dbcp.BasicDataSource;
import org.hibernate.SessionFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.orm.hibernate4.HibernateTransactionManager;
import org.springframework.orm.hibernate4.LocalSessionFactoryBuilder;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import java.util.Properties;

@EnableWebMvc
@Configuration
@ComponentScan({"org.k.photohost.**"})
@EnableTransactionManagement
@Import({SecurityConfig.class})
public class AppConfig {

    @Bean
    public SessionFactory sessionFactory(){
        LocalSessionFactoryBuilder builder = new LocalSessionFactoryBuilder(getDataSource());
        builder.scanPackages("org.k.photohost.auth.model").addProperties(getHibernateProperties());
        return builder.buildSessionFactory();
    }

    private Properties getHibernateProperties(){
        Properties properties = new Properties();
        properties.put("hibernate.format_sql", "true");
        properties.put("hibernate.show_sql", "true");
        properties.put("hibernate.dialect", "org.hibernate.dialect.MySQL5Dialect");
        properties.put("hibernate.hbm2ddl.auto", "create");
        return properties;
    }

    @Bean
    public BasicDataSource getDataSource(){
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://localhost:3306/auth?createDatabaseIfNotExist=true&useUnicode=true&useJDBCCompliantTimezoneShift=true&use\u200C\u200BLegacyDatetimeCode=false&serverTimezone=UTC");
        dataSource.setUsername("root");
        dataSource.setPassword("root");
        return dataSource;
    }

    @Bean
    public HibernateTransactionManager transactionManager(){
        return new HibernateTransactionManager(sessionFactory());
    }

    @Bean
    public ViewResolver viewResolver(){
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/view/");
        resolver.setSuffix(".jsp");
        return resolver;
    }

    @Bean
    public JavaMailSenderImpl javaMailSender(){
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
            mailSender.setHost("smtp.gmail.com");
            mailSender.setPort(465);
            mailSender.setProtocol("smtps");
            mailSender.setUsername("itra.kolenchenko@gmail.com");
            mailSender.setPassword("itransition");
        final Properties javaMailProps = new Properties();
        javaMailProps.put("mail.smtp.auth", true);
        javaMailProps.put("mail.smtp.starttls.enable", true);
        mailSender.setJavaMailProperties(javaMailProps);
        return mailSender;
    }
}
