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
            // 파일을 Resource 객체로 변환
            Resource resource = new UrlResource(filePath.toUri());
            if (resource.exists() || resource.isReadable()) {
                // 이미지 파일이 존재하면 HTTP 응답에 포함하여 반환
            	
            	System.out.println("getFile end");
            	
                return ResponseEntity.ok()
                        .contentType(MediaType.IMAGE_JPEG)
                        .body(resource);
            } else {
                // 파일이 존재하지 않거나 읽을 수 없는 경우 404 응답 반환
            	
            	System.out.println("getFile end");
            	
                return ResponseEntity.notFound().build();
            }
        } catch (IOException e) {
            // 파일을 읽는 도중 예외 발생 시 500 응답 반환
        	
        	System.out.println("getFile end");
        	
            return ResponseEntity.status(500).build();
        }
		
	}//end of getFile;
	
}
