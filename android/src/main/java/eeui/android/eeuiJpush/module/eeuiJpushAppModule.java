package eeui.android.eeuiJpush.module;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.util.Log;
import android.widget.Toast;

import com.taobao.weex.annotation.JSMethod;
import com.taobao.weex.bridge.JSCallback;

import java.util.Calendar;
import java.util.HashSet;
import java.util.Set;

import app.eeui.framework.extend.base.WXModuleBase;
import cn.jpush.android.api.JPushInterface;
import cn.jpush.android.api.JPushMessage;
import cn.jpush.android.api.TagAliasCallback;
import cn.jpush.android.service.JPushMessageReceiver;

public class eeuiJpushAppModule extends WXModuleBase {
    private int AliasSequence;
    private int TagsSequence;
    Set<String> sets = new HashSet<>();

    /**
     * 简单演示
     * @param msg
     */
    @JSMethod
    public void simple(String msg) {
        Toast.makeText(getContext(), msg, Toast.LENGTH_SHORT).show();
    }

    /**
     * 回调演示
     * @param msg
     * @param callback
     */
    @JSMethod
    public void call(final String msg, final JSCallback callback) {
        AlertDialog.Builder localBuilder = new AlertDialog.Builder(getContext());
        localBuilder.setTitle("demo");
        localBuilder.setMessage(msg);
        localBuilder.setPositiveButton("确定", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                if (callback != null) {
                    callback.invoke("返回：" + msg); //多次回调请使用invokeAndKeepAlive
                }
            }
        });
        AlertDialog dialog = localBuilder.setCancelable(false).create();
        dialog.show();
    }

    /**
     * 同步返回演示
     * @param msg
     * @return
     */
    @JSMethod(uiThread = false)
    public String retMsg(String msg) {
        return "返回：" + msg;
    }

    @JSMethod
    public void setTags(final JSCallback callback) {
      //  sets.add("test2");
      //  sets.add("test3");
        sets.add("test1");
        TagsSequence = Calendar.getInstance().get(Calendar.SECOND);
        JPushInterface.setTags(getContext(),TagsSequence,sets);

    }

    @JSMethod
    public void deleteTags(final JSCallback callback) {
        JPushInterface.deleteTags(getContext(),TagsSequence,sets);
    }

    @JSMethod
    public void getAllTags(final JSCallback callback) {
        JPushInterface.getAllTags(getContext(),TagsSequence);
    }

    @JSMethod
    public void clearTags(final JSCallback callback) {
        JPushInterface.cleanTags(getContext(),TagsSequence);
    }

    @JSMethod
    public void setAlias(final JSCallback callback) {
        AliasSequence = Calendar.getInstance().get(Calendar.SECOND);
        JPushInterface.setAlias(getContext(),AliasSequence,"test123456");
    }

    @JSMethod
    public void getAlias(final JSCallback callback) {
        JPushInterface.getAlias(getContext(),AliasSequence);
    }

    @JSMethod
    public void deleteAlias(final JSCallback callback) {
        JPushInterface.deleteAlias(getContext(),AliasSequence);
    }
}
