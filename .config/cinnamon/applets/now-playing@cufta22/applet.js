const Applet = imports.ui.applet;
const Util = imports.misc.util;
const GLib = imports.gi.GLib;
const Mainloop = imports.mainloop;
const Lang = imports.lang;
const Settings = imports.ui.settings;

const UUID = "now-playing@cufta22";
const APPLET_PATH = imports.ui.appletManager.appletMeta[UUID].path;

function MyApplet(orientation, panel_height, instance_id) {
  this._init(orientation, panel_height, instance_id);
}

let iconState = 1;

MyApplet.prototype = {
  __proto__: Applet.TextIconApplet.prototype,

  _init: function (orientation, panel_height, instance_id) {
    Applet.TextIconApplet.prototype._init.call(
      this,
      orientation,
      panel_height,
      instance_id
    );

    this.settings = new Settings.AppletSettings(this, UUID, this.instance_id);
    this.settings.bindProperty(
      Settings.BindingDirection.IN,
      "update-interval",
      "update_interval",
      this._new_freq,
      null
    );

    // this.set_applet_icon_name("now-playing");
    this.set_applet_icon_path(APPLET_PATH + "/icons/state1.png");
    this.set_applet_label("Music 3");
    this.set_applet_tooltip(_("TOOLTIP"));

    // Start the update loop
    this._update_loop();
  },

  on_applet_removed_from_panel: function () {
    // stop the loop when the applet is removed
    if (this._updateLoopID) {
      Mainloop.source_remove(this._updateLoopID);
    }
  },

  _run_cmd: function (command) {
    // run a command and return the output
    try {
      let [result, stdout, stderr] = GLib.spawn_command_line_sync(command);
      if (stdout != null) {
        return stdout.toString().trim();
      }
    } catch (e) {
      global.logError(e);
    }

    return "";
  },

  _get_status: function () {
    let mediaStatus = this._run_cmd("playerctl status");

    // If nothing is playing
    if (mediaStatus !== "Playing") {
      this.set_applet_label("");
      this.set_applet_icon_path(APPLET_PATH + `/icons/empty.png`);
      return;
      // return Mainloop.source_remove(this._updateLoopID);
    }

    // Update icon
    iconState = iconState === 3 ? 1 : iconState + 1;
    this.set_applet_icon_path(APPLET_PATH + `/icons/state${iconState}.png`);

    // Update label
    let mediaTitle = this._run_cmd("playerctl metadata title");
    let mediaArtist = this._run_cmd("playerctl metadata artist");

    // Fix for NXC
    const mediaLabel = ["nightcore", "-"].includes(mediaTitle.toLowerCase())
      ? mediaTitle
      : `${mediaArtist} - ${mediaTitle}`;

    this.set_applet_label(mediaLabel);
  },

  _update_loop: function () {
    this._get_status();

    // run the loop every x ms
    this._updateLoopID = Mainloop.timeout_add(
      this.update_interval || 1000,
      Lang.bind(this, this._update_loop)
    );
  },

  //   on_applet_clicked: function () {
  //     Util.spawn("xkill");
  //   },
};

function main(metadata, orientation, panel_height, instance_id) {
  return new MyApplet(orientation, panel_height, instance_id);
}
