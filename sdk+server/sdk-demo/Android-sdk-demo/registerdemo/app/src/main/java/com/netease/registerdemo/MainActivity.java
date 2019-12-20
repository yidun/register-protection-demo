package com.netease.registerdemo;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import com.netease.mobsec.rjsb.watchman;
import com.netease.mobsec.rjsb.RequestCallback;

public class MainActivity extends Activity {
    private EditText mEtUsername, mEtPsd , mEtNickname;
    private Button mBtRegister;
    public statc String TAG= "TestLog";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        watchman.init(getApplicationContext(), "your productNumber",new RequestCallback(){
            @Override
            public void onResult(int code, String msg) {
                Log.e(TAG,"init,code = " + code + " msg = " + msg);
            }
        });
        setContentView(R.layout.activity_main);

        mEtUsername = (EditText)findViewById(R.id.et_username);
        mEtPsd = (EditText)findViewById(R.id.et_psd);
        mEtNickname = (EditText)findViewById(R.id.et_nickname);
        mBtRegister = (Button)findViewById(R.id.bt_register);
        mBtRegister.setOnClickListener(listener);
    }

    View.OnClickListener listener = new View.OnClickListener() {
        @Override
        public void onClick(View view) {
            if (view == mBtRegister){
                String username = mEtUsername.getText().toString().trim();
                String psd = mEtPsd.getText().toString().trim();
                String nkname = mEtNickname.getText().toString().trim();
                new RegistTask(MainActivity.this){

                }.execute(username, psd,nkname);
            }
        }
    };
}
