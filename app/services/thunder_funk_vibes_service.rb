class ThunderFunkVibesService
  VIBE_MAPPING = {
    /sunny|clear/i => {
      title: "Gramatik - Just Jammin'",
      url: "https://www.youtube.com/embed/xTA_FexW3qU?si=-24uKliID_MvHyRa"
    },
    /cloudy/i => {
      title: "Guts - And The Living Is Easy",
      url: "https://www.youtube.com/embed/2tvx3k6AJwg?si=rYY6wFM6v34cujz5"
    },
    /overcast/i => {
      title: "Emancipator - Safe In The Steep Cliffs",
      url: "https://www.youtube.com/embed/BJIPmHKhYfk?si=VeCW55eVDgiuSj3X"
    },
    /sleet|rain|drizzle|shower/i => {
      title: "Tomppabeats - You're Cute",
      url: "https://www.youtube.com/embed/039QyF-zwWA?si=bjPaUK6kPXTuc0YO"
    },
    /thunder|lightning/i => {
      title: "Miles Davis - So What",
      url: "https://www.youtube.com/embed/ylXk1LBvIqU?si=pihJslrZ71boiRI-"
    },
    /snow|blizzard|ice pellets/i => {
      title: "Chet Baker - Almost Blue",
      url: "https://www.youtube.com/embed/z4PKzz81m5c?si=lOppSokXJmn17liE"
    },
    /fog|haze|mist/i => {
      title: "Charles Mingus - Goodbye Pork Pie Hat",
      url: "https://www.youtube.com/embed/sxz9eZ1Aons?si=F_vB0yXRLZPLrGrr"
    }
  }

  DEFAULT_VIBE = {
    title: "Herbie Hancock - Cantaloupe Island",
    url: "https://www.youtube.com/embed/8B1oIXGX0Io?si=Cx6zBxQ03lRSikiM"
  }

  def self.get_vibes(condition)
    VIBE_MAPPING.each do |pattern, vibe|
      return vibe if condition.match?(pattern)
    end
    DEFAULT_VIBE
  end
end
