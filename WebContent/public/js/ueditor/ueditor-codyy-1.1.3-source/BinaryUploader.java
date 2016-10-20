package com.baidu.ueditor.upload;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.baidu.ueditor.ExtraPathFormat;
import com.baidu.ueditor.PathFormat;
import com.baidu.ueditor.define.ActionMap;
import com.baidu.ueditor.define.AppInfo;
import com.baidu.ueditor.define.BaseState;
import com.baidu.ueditor.define.FileType;
import com.baidu.ueditor.define.State;
import com.codyy.commons.servlet.ImageUploadServlet;

public class BinaryUploader {

	public static final State save(HttpServletRequest request, Map<String, Object> conf, int actionCode) {
		FileItemStream fileStream = null;
		boolean isAjaxUpload = request.getHeader("X_Requested_With") != null;

		if (!ServletFileUpload.isMultipartContent(request)) {
			return new BaseState(false, AppInfo.NOT_MULTIPART_CONTENT);
		}

		ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());

		if (isAjaxUpload) {
			upload.setHeaderEncoding("UTF-8");
		}

		try {
			FileItemIterator iterator = upload.getItemIterator(request);

			while (iterator.hasNext()) {
				fileStream = iterator.next();

				if (!fileStream.isFormField())
					break;
				fileStream = null;
			}

			if (fileStream == null) {
				return new BaseState(false, AppInfo.NOTFOUND_UPLOAD_DATA);
			}

			// 以下需要增加对图片的额外存储模式

			String savePath = (String) conf.get("savePath");
			String originFileName = fileStream.getName();
			String suffix = FileType.getSuffixByFilename(originFileName);

			originFileName = originFileName.substring(0, originFileName.length() - suffix.length());
			savePath = savePath + suffix;

			long maxSize = ((Long) conf.get("maxSize")).longValue();

			if (!validType(suffix, (String[]) conf.get("allowFiles"))) {
				return new BaseState(false, AppInfo.NOT_ALLOW_FILE_TYPE);
			}

			String physicalPath = "";
			// 这边的路径形成需要替换
			Boolean isExtra = false;
			if (actionCode == ActionMap.UPLOAD_IMAGE) {
				Boolean extraEnable = (Boolean) conf.get("extraEnable");
				if (extraEnable) {// 开启了额外存储模式
					isExtra = true;
				}
			}

			InputStream is = fileStream.openStream();
			State storageState = null;
			String originFullName = originFileName + suffix;
			File tempFile = null;
			if (isExtra) {
				Object[] res = StorageManager.verifyFileSizeLimit(is, maxSize);
				boolean sizeLimit = (Boolean) res[0];
				tempFile = (File) res[1];
				is.close();
				is = new FileInputStream(tempFile);
				if (!sizeLimit) {
					String fileName = saveExatraImageByInputStream(request, originFullName, is);
					String extraPath = conf.get("extraPath").toString();
					savePath = ExtraPathFormat.genVisitPath(extraPath, fileName);
					storageState = new BaseState(true);
					;
					storageState.putInfo("title", originFullName);
				} else {
					storageState = new BaseState(false, AppInfo.MAX_SIZE);
				}
			} else {
				savePath = PathFormat.parse(savePath, originFileName);
				physicalPath = (String) conf.get("rootPath") + savePath;

				storageState = StorageManager.saveFileByInputStream(is, physicalPath, maxSize);
			}
			is.close();
			if (tempFile != null) {
				tempFile.delete();
			}

			if (storageState.isSuccess()) {
				storageState.putInfo("url", PathFormat.format(savePath));
				storageState.putInfo("type", suffix);
				storageState.putInfo("original", originFullName);
			}

			return storageState;
		} catch (FileUploadException e) {
			return new BaseState(false, AppInfo.PARSE_REQUEST_ERROR);
		} catch (IOException e) {
		}
		return new BaseState(false, AppInfo.IO_ERROR);
	}

	private static String saveExatraImageByInputStream(HttpServletRequest request, String originalFilename, InputStream inputStream) throws IOException {
		return ImageUploadServlet.saveFile(request, originalFilename, inputStream);
	}

	private static boolean validType(String type, String[] allowTypes) {
		List<String> list = Arrays.asList(allowTypes);
		return list.contains(type);
	}
}
