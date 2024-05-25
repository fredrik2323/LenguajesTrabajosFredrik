import java.util.ArrayList;

// Clase Persona
class Persona {
    private String nombre;
    private int edad;

    public Persona(String nombre, int edad) {
        this.nombre = nombre;
        this.edad = edad;
    }

    @Override
    public String toString() {
        return "Nombre: " + nombre + ", Edad: " + edad;
    }
}

// Clases de Contacto
abstract class Contacto extends Persona {
    public Contacto(String nombre, int edad) {
        super(nombre, edad);
    }
}

class ContactoSimple extends Contacto {
    public ContactoSimple(String nombre, int edad) {
        super(nombre, edad);
    }
}

class ContactoEspecifico extends Contacto {
    private String email;

    public ContactoEspecifico(String nombre, int edad, String email) {
        super(nombre, edad);
        this.email = email;
    }

    @Override
    public String toString() {
        return super.toString() + ", Email: " + email;
    }
}

// Interfaces y clases de Evento
interface Evento {
    String toString();
}

class EventoSimple implements Evento {
    private String descripcion;

    public EventoSimple(String descripcion) {
        this.descripcion = descripcion;
    }

    @Override
    public String toString() {
        return "Evento: " + descripcion;
    }
}

class EventoEspecifico implements Evento {
    private String lugar;
    private String descripcion;  // Correcta declaración de la variable

    public EventoEspecifico(String descripcion, String lugar) {
        this.descripcion = descripcion;
        this.lugar = lugar;
    }

    @Override
    public String toString() {
        return "Evento: " + descripcion + ", Lugar: " + lugar;
    }
}

// Abstract Factory para creación de Contactos y Eventos
interface AbstractFactory {
    Contacto getContacto(String tipo, String nombre, int edad, String email);
    Evento getEvento(String tipo, String descripcion, String lugar);
}

class FactoryProducer {
    public static AbstractFactory getFactory(String choice) {
        if (choice.equalsIgnoreCase("Contacto")) {
            return new ContactoFactory();
        } else if (choice.equalsIgnoreCase("Evento")) {
            return new EventoFactory();
        }
        return null;
    }
}

class ContactoFactory implements AbstractFactory {
    @Override
    public Contacto getContacto(String tipo, String nombre, int edad, String email) {
        if (tipo.equalsIgnoreCase("simple")) {
            return new ContactoSimple(nombre, edad);
        } else if (tipo.equalsIgnoreCase("especifico")) {
            return new ContactoEspecifico(nombre, edad, email);
        }
        return null;
    }

    @Override
    public Evento getEvento(String tipo, String descripcion, String lugar) {
        return null;  // Este método no debe crear contactos.
    }
}

class EventoFactory implements AbstractFactory {
    @Override
    public Contacto getContacto(String tipo, String nombre, int edad, String email) {
        return null;  // Este método no debe crear eventos.
    }

    @Override
    public Evento getEvento(String tipo, String descripcion, String lugar) {
        if (tipo.equalsIgnoreCase("simple")) {
            return new EventoSimple(descripcion);
        } else if (tipo.equalsIgnoreCase("especifico")) {
            return new EventoEspecifico(descripcion, lugar);
        }
        return null;
    }
}

// Clase Agenda utilizando Singleton Pattern
class Agenda {
    // Lazy Singleton implementation
    private static Agenda instance = null;
    private ArrayList<Object> items;

    private Agenda() {
        items = new ArrayList<>();
    }

    // Lazy Initialization of Singleton
    public static synchronized Agenda getInstance() {
        if (instance == null) {
            instance = new Agenda();
        }
        return instance;
    }

    public void addItem(Object item) {
        items.add(item);
    }

    public void mostrarItems() {
        for (Object item : items) {
            System.out.println(item);
        }
    }
}

// Clase Principal
public class Main {
    public static void main(String[] args) {
        Agenda agenda = Agenda.getInstance();
        AbstractFactory contactoFactory = FactoryProducer.getFactory("Contacto");
        AbstractFactory eventoFactory = FactoryProducer.getFactory("Evento");

        agenda.addItem(contactoFactory.getContacto("simple", "Juan", 30, null));
        agenda.addItem(eventoFactory.getEvento("simple", "Reunión de equipo", null));
        agenda.addItem(contactoFactory.getContacto("especifico", "Maria", 25, "maria@example.com"));
        agenda.addItem(eventoFactory.getEvento("especifico", "Conferencia de tecnología", "Centro de Convenciones"));

        

        agenda.mostrarItems();
    }
}