/**
 * Focuses alacritty or opens if it isnt already
 * Meant for linux. wmctrl needs to be installed and alacritty needs to be in PATH
 */
use std::process::Command;

fn main() {
    let output = Command::new("wmctrl")
        .arg("-xa")
        .arg("Alacritty.Alacritty")
        .output()
        .expect("Failed to execute wmctrl");

    if !output.status.success() {
        Command::new("alacritty")
            .spawn()
            .expect("Failed to execute alacritty");
    }
}
