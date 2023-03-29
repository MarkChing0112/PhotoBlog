package hkmu.comps380f.exception;

public class BookNotFound extends RuntimeException {
    public BookNotFound(long id) {
        super("Book " + id + " does not exist.");
    }
}
