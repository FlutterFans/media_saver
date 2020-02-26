package com.github.flutterfans.media_saver;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Environment;

import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.ref.WeakReference;

import io.flutter.plugin.common.MethodChannel;

/**
 * Created by yukai on 2020-02-23
 */
public class FileHelper {
    private Activity activity;
    private MethodChannel.Result result;
    private byte[] imageData;
    private String fileName;
    private String imageType;
    private String directory;
    private final int WRITE_EXTERNAL_STORAGE_REQUEST_CODE = 101;

    public FileHelper(Activity activity, MethodChannel.Result result, byte[] imageData, String fileName, String imageType, String directory) {
        this.activity = activity;
        this.result = result;
        this.imageData = imageData;
        this.fileName = fileName;
        this.imageType = imageType;
        this.directory = directory;
    }

    public boolean onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        doNext(requestCode, grantResults);
        return true;
    }

    private void doNext(int requestCode, int[] grantResults) {
        if (requestCode == WRITE_EXTERNAL_STORAGE_REQUEST_CODE) {
            if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                saveImageToGallery();
            } else {
                result.success(false);
            }
        }
    }

    public void saveImageAsync() {
        if (ContextCompat.checkSelfPermission(activity, Manifest.permission.WRITE_EXTERNAL_STORAGE)
                != PackageManager.PERMISSION_GRANTED) {
            //申请WRITE_EXTERNAL_STORAGE权限
            ActivityCompat.requestPermissions(activity, new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE},
                    WRITE_EXTERNAL_STORAGE_REQUEST_CODE);
        } else {
            saveImageToGallery();
        }
    }

    /**
     * 保存Bitmap到相册中
     *
     * @return URL
     */
    public void saveImageToGallery() {
        new ImageSaveTask(activity, imageData, directory, fileName, imageType, result).execute();
    }

    static class ImageSaveTask extends AsyncTask<Void, Void, File> {
        byte[] imageData;
        String directory;
        String fileName;
        String imageType;
        WeakReference<Activity> activityWeakReference;
        WeakReference<MethodChannel.Result> resultWeakReference;

        public ImageSaveTask(Activity activity, byte[] imageData, String directory, String fileName, String imageType, MethodChannel.Result result) {
            activityWeakReference = new WeakReference<>(activity);
            resultWeakReference = new WeakReference<>(result);
            this.imageData = imageData;
            this.directory = directory;
            this.fileName = fileName;
            this.imageType = imageType;
        }

        @Override
        protected File doInBackground(Void... voids) {
            if (imageData == null)
                return null;
            // 首先保存图片
            File file = null;

            File root = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES);
            if (directory != null) {
                root = new File(root, directory);
                root.mkdirs();
            }
            file = new File(root, fileName + "." + imageType);
            Bitmap bitmap = BitmapFactory.decodeByteArray(imageData, 0, imageData.length);
            try {
                FileOutputStream fos = new FileOutputStream(file);
                if (imageType.equals("jpg")) {
                    bitmap.compress(Bitmap.CompressFormat.JPEG, 90, fos);
                } else if (imageType.equals("png")) {
                    bitmap.compress(Bitmap.CompressFormat.PNG, 100, fos);
                } else if (imageType.equals("gif")) {
                    fos.write(imageData);
                }
                fos.flush();
                fos.close();
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return file;
        }

        @Override
        protected void onPostExecute(File file) {
            final Activity activity = activityWeakReference.get();
            MethodChannel.Result result = resultWeakReference.get();

            if (activity == null || file == null) {
                result.success(false);
                return;
            }
            Uri uri = Uri.fromFile(file);
            activity.sendBroadcast(new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, uri));
            result.success(true);
//            result.success(file.getPath());
        }
    }

}
