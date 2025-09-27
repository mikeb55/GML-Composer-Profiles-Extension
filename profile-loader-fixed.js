// Fixed Profile Loader - Points to profiles-data.js
const PROFILE_SOURCE = 'https://raw.githubusercontent.com/mikeb55/GML-Composer-Profiles-Extension/main/profiles-data.js';

async function loadProfiles() {
    try {
        const response = await fetch(PROFILE_SOURCE);
        const scriptText = await response.text();
        eval(scriptText);
        return window.composerProfiles;
    } catch (error) {
        console.error('Failed to load profiles:', error);
        return null;
    }
}
