/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.util;

import com.bpps.pojo.SymptomImage;
import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author Administrator
 */
public class UploadFile {

    public String uploadImage(FormFile formFile, HttpServletRequest request, int width, int height) {

        String savePath = request.getSession().getServletContext().getRealPath("/") + "attached/";
        String saveUrl = request.getContextPath() + "/attached/";
        //检查目录
        File uploadDir = new File(savePath);
        if (!uploadDir.isDirectory()) {
            System.out.println("上传目录不存在。");
            return null;
        }
        //检查目录写权限
        if (!uploadDir.canWrite()) {
            System.out.println("上传目录没有写权限。");
            return null;
        }

        String dirName = "image";
        //创建文件夹
        savePath += dirName + "/";
        saveUrl += dirName + "/";
        File saveDirFile = new File(savePath);
        if (!saveDirFile.exists()) {
            saveDirFile.mkdirs();
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String ymd = sdf.format(new Date());
        savePath += ymd + "/";
        saveUrl += ymd + "/";
        File dirFile = new File(savePath);
        if (!dirFile.exists()) {
            dirFile.mkdirs();
        }

        HashMap<String, String> extMap = new HashMap<String, String>();
        extMap.put("image", "gif,jpg,jpeg,png,bmp");
        extMap.put("flash", "swf,flv");
        extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");
        extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");

        String fileName = formFile.getFileName();
        long fileSize = formFile.getFileSize();
        if (fileSize == 0 || fileName.equals("")) {
            System.out.println("文件名为空或文件大小为0");
            return null;
        }
        String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        if (!Arrays.<String>asList(extMap.get(dirName).split(",")).contains(fileExt)) {
            System.out.println("上传文件扩展名是不允许的扩展名。只允许" + extMap.get(dirName) + "格式。");
            return null;
        }
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;
        String newFileCompressName = df.format(new Date()) + "_" + new Random().nextInt(1001) + ".jpg";
        String tmpPath = savePath + newFileName;
        saveUrl += newFileCompressName;
//        System.out.println(tmpPath);
//        System.out.println(savePath);
//        System.out.println(saveUrl);

        try {
            FileOutputStream fos;
            fos = new FileOutputStream(tmpPath);
            fos.write(formFile.getFileData());//写入字节
            fos.flush();
            fos.close();
            CompressImage mypic = new CompressImage();//压缩图片
            mypic.compressPic(savePath, savePath, newFileName, newFileCompressName, width, height, true);
            deleteFolder(tmpPath);
        } catch (Exception ex) {
            System.out.println("写入文件失败");
            ex.printStackTrace();
        }
        return saveUrl;
    }
    
    
    public String uploadSymImage(SymptomImage symptomImage, HttpServletRequest request) {

        String savePath = request.getSession().getServletContext().getRealPath("/") + "attached/";
        String saveUrl = request.getContextPath() + "/attached/";
        //检查目录
        File uploadDir = new File(savePath);
        if (!uploadDir.isDirectory()) {
            System.out.println("上传目录不存在。");
            return null;
        }
        //检查目录写权限
        if (!uploadDir.canWrite()) {
            System.out.println("上传目录没有写权限。");
            return null;
        }

        String dirName = "image";
        //创建文件夹
        savePath += dirName + "/";
        saveUrl += dirName + "/";
        File saveDirFile = new File(savePath);
        if (!saveDirFile.exists()) {
            saveDirFile.mkdirs();
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String ymd = sdf.format(new Date());
        savePath += ymd + "/";
        saveUrl += ymd + "/";
        File dirFile = new File(savePath);
        if (!dirFile.exists()) {
            dirFile.mkdirs();
        }

        HashMap<String, String> extMap = new HashMap<String, String>();
        extMap.put("image", "gif,jpg,jpeg,png,bmp");
        extMap.put("flash", "swf,flv");
        extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");
        extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");

        FormFile formFile = symptomImage.getSiImage();
        String fileName = formFile.getFileName();
        long fileSize = formFile.getFileSize();
        if (fileSize == 0 || fileName.equals("")) {
            System.out.println("文件名为空或文件大小为0");
            return null;
        }
        String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        if (!Arrays.<String>asList(extMap.get(dirName).split(",")).contains(fileExt)) {
            System.out.println("上传文件扩展名是不允许的扩展名。只允许" + extMap.get(dirName) + "格式。");
            return null;
        }
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        String newFilePerfix = df.format(new Date()) + "_" + new Random().nextInt(1000) + "_" + symptomImage.getSymId();
        String srcFileName = newFilePerfix + "." + fileExt;
        String bigImageName = newFilePerfix + "_b.jpg";
        String smlImageName = newFilePerfix + "_s.jpg";
        String tmpPath = savePath + srcFileName;
        saveUrl += newFilePerfix;
//        System.out.println(tmpPath);
//        System.out.println(savePath);
//        System.out.println(saveUrl);

        try {
            FileOutputStream fos;
            fos = new FileOutputStream(tmpPath);
            fos.write(formFile.getFileData());//写入字节
            fos.flush();
            fos.close();
            CompressImage mypic = new CompressImage();//压缩图片
            mypic.compressPic(savePath, savePath, srcFileName, bigImageName, 600, 400, true);
            mypic.compressPic(savePath, savePath, srcFileName, smlImageName, 200, 200, true);
            deleteFolder(tmpPath);
        } catch (Exception ex) {
            System.out.println("写入文件失败");
            ex.printStackTrace();
        }
        return saveUrl;
    }

    public String uploadImage(HttpServletRequest request) throws FileUploadException {
        String savePath = request.getSession().getServletContext().getRealPath("/") + "attached/";
        //System.out.println("save path="+savePath);
        //文件保存目录URL
        String saveUrl = request.getContextPath() + "/attached/";
        //System.out.println("save url="+saveUrl);
        //save url=/bpps/attached/
        //save path=H:\program\java\bpps\build\web\attached/

        //定义允许上传的文件扩展名
        HashMap<String, String> extMap = new HashMap<String, String>();
        extMap.put("image", "gif,jpg,jpeg,png,bmp");
        extMap.put("flash", "swf,flv");
        extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");
        extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2");

        //最大文件大小
        long maxSize = 1000000;

        if (!ServletFileUpload.isMultipartContent(request)) {
            System.out.println("请选择文件。");
            return null;
        }
        //检查目录
        File uploadDir = new File(savePath);
        if (!uploadDir.isDirectory()) {
            System.out.println("上传目录不存在。");
            return null;
        }
        //检查目录写权限
        if (!uploadDir.canWrite()) {
            System.out.println("上传目录没有写权限。");
            return null;
        }

        String dirName = request.getParameter("dir");
        if (dirName == null) {
            dirName = "image";
        }
        if (!extMap.containsKey(dirName)) {
            System.out.println("目录名不正确。");
            return null;
        }
        //创建文件夹
        savePath += dirName + "/";
        saveUrl += dirName + "/";
        File saveDirFile = new File(savePath);
        if (!saveDirFile.exists()) {
            saveDirFile.mkdirs();
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String ymd = sdf.format(new Date());
        savePath += ymd + "/";
        saveUrl += ymd + "/";
        File dirFile = new File(savePath);
        if (!dirFile.exists()) {
            dirFile.mkdirs();
        }

        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setHeaderEncoding("UTF-8");
        List items = upload.parseRequest(request);
        Iterator itr = items.iterator();
        while (itr.hasNext()) {
            FileItem item = (FileItem) itr.next();
            String fileName = item.getName();
            long fileSize = item.getSize();
            if (!item.isFormField()) {
                //检查文件大小
                //if (item.getSize() > maxSize) {
                //System.out.println("上传文件大小超过限制。");
                //}
                //检查扩展名
                String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                if (!Arrays.<String>asList(extMap.get(dirName).split(",")).contains(fileExt)) {
                    System.out.println("上传文件扩展名是不允许的扩展名。\n只允许" + extMap.get(dirName) + "格式。");
                    return null;
                }

                SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
                String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;
                String newFileComName = df.format(new Date()) + "_" + new Random().nextInt(1001) + ".jpg";
                saveUrl += newFileComName;
                try {
                    File uploadedFile = new File(savePath, newFileName);
                    item.write(uploadedFile);
                    CompressImage mypic = new CompressImage();//压缩图片
                    mypic.compressPic(savePath, savePath, newFileName, newFileComName, 200, 200, true);
                } catch (Exception e) {
                    System.out.println("上传文件失败。");
                    return null;
                }

            }
        }
        return saveUrl;
    }

    public boolean deleteFolder(String sPath) {
        boolean flag = false;
        File file = new File(sPath);
        // 判断目录或文件是否存在
        if (!file.exists()) {  // 不存在返回 false
            return flag;
        } else {
            // 判断是否为文件
            if (file.isFile()) {  // 为文件时调用删除文件方法

                return file.delete();
            } else {  // 为目录时调用删除目录方法
                return false;
            }
        }
    }
}
