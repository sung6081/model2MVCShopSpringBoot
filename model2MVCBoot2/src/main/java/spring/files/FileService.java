package spring.files;

import java.util.List;

import spring.domain.File;

public interface FileService {
	
	public void addFile(File file);
	
	public void updateFile(File file);
	
	public List<File> getFilesList(int prodNo);
	
}
