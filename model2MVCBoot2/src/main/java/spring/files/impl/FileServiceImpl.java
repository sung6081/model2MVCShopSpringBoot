package spring.files.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import spring.domain.File;
import spring.files.FileDao;
import spring.files.FileService;

@Service("fileServiceImpl")
public class FileServiceImpl implements FileService {

	@Autowired
	@Qualifier("fileDao")
	private FileDao fileDao;
	
	public FileServiceImpl() {
		System.out.println("Default FileServiceImpl Constructor call...");
	}
	
	public void setFileDao(FileDao fileDao) {
		this.fileDao = fileDao;
	}

	@Override
	public void addFile(File file) {
		// TODO Auto-generated method stub
		fileDao.addFile(file);
	}

	@Override
	public void updateFile(File file) {
		// TODO Auto-generated method stub
		fileDao.updateFile(file);
	}

	@Override
	public List<File> getFilesList(int prodNo) {
		// TODO Auto-generated method stub
		return fileDao.getFilesList(prodNo);
	}

}
