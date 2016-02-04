package com.example.kyleohanian.ultimatebaseballstatistics;

import android.app.Activity;
import android.app.FragmentTransaction;
import android.net.Uri;
import android.os.Bundle;
import android.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class Calculator extends Fragment {
    View.OnClickListener activity;
    EditText hits,ab,s,d,t,hr,rbi;
    TextView BA;
    static double ba;
    Button calculate;
    static ResultFragment r = new ResultFragment();
    int[] stats = new int[7];
    public static Calculator newInstance(View.OnClickListener activity) {
        Calculator c = new Calculator();
        r = ResultFragment.newInstance(activity);
        c.activity = activity;
        return c;
    }
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_calculator, container, false);
        this.calculate = (Button)view.findViewById(R.id.button);
        calculate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getStats();
                double d = (double)stats[0];
                if (stats[1] == 0 && stats[0] >= 1 && !Double.isNaN(returnBattingAverage())) {
                    Toast.makeText(getActivity(), "Can't Have Zero At-Bats",
                            Toast.LENGTH_LONG).show();
                }
                else if(Double.isNaN(returnBattingAverage())) {
                    getBattingAverage();
                    FragmentTransaction ft = getFragmentManager().beginTransaction();
                    ft.replace(R.id.main, r);
                    ft.commit();
                }
                else if (stats[0] > stats[1]) {
                    Toast.makeText(getActivity(), "Number of Hits Cannot Be Greater Than Number of At-Bats",
                            Toast.LENGTH_LONG).show();
                }
                else {
                    getBattingAverage();
                    FragmentTransaction ft = getFragmentManager().beginTransaction();
                    ft.replace(R.id.main, r);
                    ft.commit();
                }
                //Log.d("TAG", "Transaction completed");
            }
        });
        this.hits = (EditText)view.findViewById(R.id.EditText);
        this.ab = (EditText)view.findViewById(R.id.EditText1);
        this.BA = (TextView) view.findViewById(R.id.textView5);
        return view;
    }
    public void getStats() {
        try {
            stats[0] = Integer.parseInt(hits.getText().toString());
            Log.d("TAG", "Hits = " + stats[0]);
            stats[1] = Integer.parseInt(ab.getText().toString());
            Log.d("TAG", "At Bats = " + stats[1]);
        }
        catch (Exception e) {
            Log.d("TAG","Invalid");
        }
    }
    public double getBattingAverage() {
        try {
            double d = (double) stats[0] / stats[1];
            Log.d("TAG", "Batting Average = " + d);
            ba = d;
            return d;
        }
        catch (Exception e) {
            ba = Double.NaN;
        }
        return ba;
    }

    public static double returnBattingAverage() {
        return ba;
    }

}