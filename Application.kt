package Hello

import org.slf4j.LoggerFactory
import org.springframework.boot.CommandLineRunner
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean

@SpringBootApplication
class Application {
    private val log = LoggerFactory.getLogger(Application::class.java)

    @Bean
    fun init(repository: CustomerRepository) = CommandLineRunner {
        repository.save(Customer("Jack", "Bauer"))
        repository.save(Customer("Chole", "O'Brian"))
        repository.save(Customer("Kim", "Bauer"))
        repository.save(Customer("David", "Palmer"))
        repository.save(Customer("Michelle", "Dessler"))

        log.info("Customers found with findAll():")
        log.info("---------------------")
        repository.findAll().forEach { log.info(it.toString()) }
        log.info("")

        val customer = repository.findById(1L)
        customer.ifPresent {
            log.info("Customer found by findbyID(1L):")
            log.info("--------------------")
            log.info(it.toString())
            log.info("")
        }

        log.info("Customer found with findByLastName('Bauer'):")\
        log.info("----------------------")
        repository.findByLastName("Bauer").forEach { log.info(it.toString()) }
        log.info("")
    }
}

fun main() {
    runApplication<Application>()
}