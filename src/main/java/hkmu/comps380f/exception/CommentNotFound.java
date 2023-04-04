package hkmu.comps380f.exception;

import java.util.UUID;

public class CommentNotFound extends RuntimeException{
    public CommentNotFound(long id) {
        super ("Comment" + id + "does not exit.");
    }
}
