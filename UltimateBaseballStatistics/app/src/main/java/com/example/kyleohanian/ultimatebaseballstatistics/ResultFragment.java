package com.example.kyleohanian.ultimatebaseballstatistics;

import android.app.FragmentTransaction;
import android.os.Bundle;
import android.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import java.text.DecimalFormat;
import java.text.NumberFormat;

public class ResultFragment extends Fragment {

        View.OnClickListener activity;
        LayoutInflater inflater;
        ViewGroup container;
        Button button2;
        static TextView BA;
        Calculator calculator;


        public static ResultFragment newInstance(View.OnClickListener activity) {
            ResultFragment r = new ResultFragment();
            r.activity = activity;
            return r;
        }
        public void onCreate(Bundle bundle) {
            super.onCreate(bundle);
            onCreateView(inflater, container, bundle);
        }

        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                                  Bundle bundle) {
            if (container == null) {
                return null;
            }
            this.calculator = Calculator.newInstance(activity);
            View view = inflater.inflate(R.layout.results, container, false);
            this.button2 = (Button)view.findViewById(R.id.button2);
            this.BA = (TextView) view.findViewById(R.id.textView5);
            if(Double.isNaN(Calculator.returnBattingAverage())) {
                BA.setText("N/A");
            }
            else
                setBattingAverage(Calculator.returnBattingAverage());
            Log.d("TAG",BA.getText().toString());
            Log.d("TAG","View Returned");

            button2.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    FragmentTransaction ft = getFragmentManager().beginTransaction();
                    ft.replace(R.id.main, calculator);
                    ft.commit();
                }
            });

            return view;
        }
        public void setBattingAverage(double a) {
            double d = Double.parseDouble(Double.toString(a));
            NumberFormat formatter = new DecimalFormat("#.000");
            BA.setText(formatter.format(d));
        }

}
