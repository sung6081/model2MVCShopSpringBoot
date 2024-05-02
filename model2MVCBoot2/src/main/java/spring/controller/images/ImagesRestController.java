package spring.controller.images;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ImagesRestController {

	private final Path imageDir = Paths.get("C:/Users/user/git/repository8/model2MVCBoot2/src/main/resources/static/images/uploadFiles");
	
	@GetMapping("/images/uploadFiles/{fileName}")
	public ResponseEntity<Resource> getFile(@PathVariable String fileName) {
		
		System.out.println("getFile start");
		
		Path filePath = imageDir.resolve(fileName);
        try {
            // ������ Resource ��ü�� ��ȯ
            Resource resource = new UrlResource(filePath.toUri());
            if (resource.exists() || resource.isReadable()) {
                // �̹��� ������ �����ϸ� HTTP ���信 �����Ͽ� ��ȯ
            	
            	System.out.println("getFile end");
            	
                return ResponseEntity.ok()
                        .contentType(MediaType.IMAGE_JPEG)
                        .body(resource);
            } else {
                // ������ �������� �ʰų� ���� �� ���� ��� 404 ���� ��ȯ
            	
            	System.out.println("getFile end");
            	
                return ResponseEntity.notFound().build();
            }
        } catch (IOException e) {
            // ������ �д� ���� ���� �߻� �� 500 ���� ��ȯ
        	
        	System.out.println("getFile end");
        	
            return ResponseEntity.status(500).build();
        }
		
	}//end of getFile;
	
}
