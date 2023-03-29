package hkmu.comps380f.exception;

import java.util.UUID;

public class AttachmentNotFound extends RuntimeException {
    public AttachmentNotFound(UUID id) {
        super("Attachment " + id + " does not exist.");
    }
}
