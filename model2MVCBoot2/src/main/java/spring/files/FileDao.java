package spring.files;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import spring.domain.File;

@Mapper
public interface FileDao {
	
	public void addFile(File file);
	
	public void updateFile(File file);
	
	public List<File> getFilesList(int prodNo);
	
}//end of interface
