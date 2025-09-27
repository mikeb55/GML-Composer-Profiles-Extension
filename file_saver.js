// File System Save Module for Composer-Profiles
// Note: This requires running a local server or using Electron for file system access

function saveProfileToFile(profile) {
    // For browser-based saving (downloads to user's Downloads folder)
    const filename = profile.name + '_' + Date.now() + '.json';
    const data = JSON.stringify(profile, null, 2);
    const blob = new Blob([data], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = filename;
    a.click();
    
    console.log('Profile downloaded as:', filename);
    console.log('Move this file to: C:\\Users\\mike\\Documents\\gml-workspace\\gml-composer-profiles-extension\\composer-profiles-data\\');
}

// Add this to your existing saveProfile function
function saveProfileWithFile() {
    if (!currentProfile) return;
    
    // Save to localStorage (for backward compatibility)
    savedProfiles.push(currentProfile);
    localStorage.setItem('composerProfiles', JSON.stringify(savedProfiles));
    
    // Also save as file
    saveProfileToFile(currentProfile);
    
    alert('Profile saved!\nFile downloaded to your Downloads folder.\nMove it to composer-profiles-data folder.');
}
