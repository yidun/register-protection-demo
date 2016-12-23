package com.netease.registerdemo;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import com.netease.mobrcsec.rjsb.RjsbHandler;

public class MainActivity extends Activity {
    private EditText mEtUsername, mEtPsd , mEtNickname;
    private Button mBtRegister;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        RjsbHandler.setBusinessId(getApplicationContext(), "YOUR_BUSINESS_ID");
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