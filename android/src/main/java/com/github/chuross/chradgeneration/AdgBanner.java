package com.github.chuross.chradgeneration;

import android.content.Context;
import android.view.View;
import android.widget.FrameLayout;

import com.socdm.d.adgeneration.ADG;
import com.socdm.d.adgeneration.ADGConsts;
import com.socdm.d.adgeneration.ADGListener;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class AdgBanner implements PlatformView, MethodChannel.MethodCallHandler {
    public static final String NAME = "com.github.chuross.widget/adgbanner";
    private FrameLayout container;
    private ADG adg;

    AdgBanner(Context context, BinaryMessenger messenger, int id) {
        MethodChannel methodChannel = new MethodChannel(messenger, NAME + "_" + id);
        methodChannel.setMethodCallHandler(this);

        container = new FrameLayout(context);
        container.setLayoutParams(new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT));

        adg = new ADG(context);
        adg.setAdListener(new ADGListener() {
            @Override
            public void onReceiveAd() {
            }

            @Override
            public void onFailedToReceiveAd(ADGConsts.ADGErrorCode errorCode) {
                switch (errorCode) {
                    case EXCEED_LIMIT:
                    case NEED_CONNECTION:
                    case NO_AD:
                        break;
                    default:
                        if (adg != null) adg.start();
                        break;
                }
            }
        });

        container.addView(adg);
    }

    @Override
    public View getView() {
        return container;
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        switch (methodCall.method) {
            case "load":
                load(methodCall, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void load(MethodCall methodCall, MethodChannel.Result result) {
        if (adg == null) return;

        String locationId = methodCall.argument("locationId");
        String type = methodCall.argument("type");

        if (locationId == null) {
            result.error("locationId is null", null, null);
            return;
        }

        adg.setLocationId(locationId);

        String targetType = type != null ? type : "sp";

        switch (targetType) {
            case "sp":
                adg.setAdFrameSize(ADG.AdFrameSize.SP);
                break;
            case "large":
                adg.setAdFrameSize(ADG.AdFrameSize.LARGE);
                break;
            case "rect":
                adg.setAdFrameSize(ADG.AdFrameSize.RECT);
                break;
            default:
                result.error("invalid banner type", null, null);
                return;
        }

        adg.start();
        result.success(null);
    }

    @Override
    public void dispose() {
        if (adg != null) {
            adg.stop();
            adg = null;
        }

        if (container != null) {
            container.removeAllViews();
            container = null;
        }
    }
}
