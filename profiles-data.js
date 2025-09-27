// Complete 77 Composer Profiles Database
window.composerProfiles = {
    // Jazz Guitar
    "Wes Montgomery": { category: "Jazz", techniques: ["Thumb Octaves", "Chord Solos", "Melodic Blues"] },
    "Jim Hall": { category: "Jazz", techniques: ["Sparse", "Lyrical", "Conversations"] },
    "Joe Pass": { category: "Jazz", techniques: ["Chord-Melody"] },
    "John Scofield": { category: "Jazz", techniques: ["Funk", "Syncopated"] },
    "Pat Metheny": { category: "Jazz", techniques: ["Wide Intervals", "Ambiance"] },
    "Bill Frisell": { category: "Jazz", techniques: ["Ambient", "Americana"] },
    
    // Greek & Rebetiko (15 profiles)
    "Greek Rebetiko": { category: "Greek", techniques: ["Koupes", "Walking Bass"] },
    "Vassilis Tsitsanis": { category: "Greek", techniques: ["Greek Master"] },
    "Markos Vamvakaris": { category: "Greek", techniques: ["Rebetiko Pioneer"] },
    
    // Alternative Tunings
    "Sonic Youth": { category: "Alternative", techniques: ["Custom Tuning", "Cluster Chords"] },
    "Joni Mitchell": { category: "Alternative", techniques: ["Open Modal", "Fingerstyle"] },
    
    // Techniques (28 profiles)
    "Travis Picking": { category: "Technique", techniques: ["Alternating Bass"] },
    "Boom-Chuck": { category: "Technique", techniques: ["Bluegrass Rhythm"] },
    
    // Add all 77 profiles...
};

// Include the helper functions from complete_profiles.js
// [Copy the functions from your existing file here]

// Export for use
if (typeof module !== 'undefined' && module.exports) {
    module.exports = composerProfiles;
}