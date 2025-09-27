// Profile Loader - Auto-generated
// Source: GML-Composer-Profiles-Extension
// Updated: Sat 09/27/2025 18:50:51.07

const PROFILE_SOURCE = 'https://raw.githubusercontent.com/mikeb55/GML-Composer-Profiles-Extension/main/complete_profiles.js';

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
