
package com.phonegap.pgsidebar;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaResourceApi;
import org.apache.cordova.PermissionHelper;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.media.AudioManager;
import android.net.Uri;
import android.os.Build;
import android.util.Log;

import java.security.Permission;
import java.util.ArrayList;

import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;

public class PGSideBar extends CordovaPlugin {

    /**
     * Constructor.
     */
    public PGSideBar() {

    }

    /**
     * Executes the request and returns PluginResult.
     * @param action 		The action to execute.
     * @param args 			JSONArry of arguments for the plugin.
     * @param callbackContext		The callback context used when calling back into JavaScript.
     * @return 				A PluginResult object with a status and message.
     */
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

        if (action.equals("show")) {
            JSONArray labels = args.getJSONArray(0);
            this.showSideBar(labels,callbackContext);
        }
        else if(action.equals("hide")) {
        	this.hideSideBar(callbackContext);
        }


    }

    private void showSideBar(final JSONArray labels, final CallbackContext callbackContext) {
    	// TODO: if sidebar does not exist, we need to create it

    	// DrawerLayout mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
     //    ListView mList = (ListView) findViewById(R.id.left_drawer);

     //    // Set the adapter for the list view
     //    mList.setAdapter(new ArrayAdapter<String>(this,
     //            R.layout.drawer_list_item, labels));
     //    // Set the list's click listener
     //    mList.setOnItemClickListener(new DrawerItemClickListener());
    }

    private void hideSideBar(final CallbackContext callbackContext) {

    }




}
