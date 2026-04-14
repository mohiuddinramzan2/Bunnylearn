import { useState, useEffect } from "react";

const RabbitCharacter = ({ mood = "happy", bounce = false }) => (
  <div style={{
    display: "inline-block",
    animation: bounce ? "rabbitBounce 0.6s ease-in-out infinite alternate" : "float 3s ease-in-out infinite",
    filter: "drop-shadow(0 8px 16px rgba(0,0,0,0.15))"
  }}>
    <svg width="120" height="140" viewBox="0 0 120 140" fill="none">
      {/* Ears */}
      <ellipse cx="38" cy="30" rx="14" ry="30" fill="#F9C8D0" />
      <ellipse cx="82" cy="30" rx="14" ry="30" fill="#F9C8D0" />
      <ellipse cx="38" cy="30" rx="8" ry="22" fill="#F4A0B0" />
      <ellipse cx="82" cy="30" rx="8" ry="22" fill="#F4A0B0" />
      {/* Head */}
      <ellipse cx="60" cy="72" rx="40" ry="38" fill="#FDEEF1" />
      {/* Cheeks */}
      <ellipse cx="36" cy="82" rx="12" ry="8" fill="#FFADC0" opacity="0.6" />
      <ellipse cx="84" cy="82" rx="12" ry="8" fill="#FFADC0" opacity="0.6" />
      {/* Eyes */}
      <circle cx="46" cy="66" r="10" fill="white" />
      <circle cx="74" cy="66" r="10" fill="white" />
      <circle cx="48" cy="67" r="6" fill="#2D2D2D" />
      <circle cx="76" cy="67" r="6" fill="#2D2D2D" />
      <circle cx="50" cy="65" r="2.5" fill="white" />
      <circle cx="78" cy="65" r="2.5" fill="white" />
      {/* Nose */}
      <ellipse cx="60" cy="80" rx="5" ry="4" fill="#FF8FAB" />
      {/* Mouth */}
      {mood === "happy" ? (
        <>
          <path d="M52 87 Q60 96 68 87" stroke="#FF8FAB" strokeWidth="2.5" fill="none" strokeLinecap="round" />
        </>
      ) : (
        <path d="M54 90 Q60 86 66 90" stroke="#FF8FAB" strokeWidth="2.5" fill="none" strokeLinecap="round" />
      )}
      {/* Body */}
      <ellipse cx="60" cy="122" rx="28" ry="20" fill="#FDEEF1" />
      {/* Arms */}
      <ellipse cx="30" cy="115" rx="10" ry="16" fill="#FDEEF1" transform="rotate(-20 30 115)" />
      <ellipse cx="90" cy="115" rx="10" ry="16" fill="#FDEEF1" transform="rotate(20 90 115)" />
      {/* Star accessory */}
      <text x="80" y="58" fontSize="14" textAnchor="middle">⭐</text>
    </svg>
  </div>
);

const sections = [
  {
    id: "abc",
    label: "Learn ABC",
    emoji: "🔤",
    color: "#FF6B6B",
    bg: "#FFF0F0",
    accent: "#FFD6D6",
    desc: "Letters & Sounds",
  },
  {
    id: "words",
    label: "Words",
    emoji: "📖",
    color: "#FF9F43",
    bg: "#FFF5E6",
    accent: "#FFE5B4",
    desc: "Build Vocabulary",
  },
  {
    id: "games",
    label: "Games",
    emoji: "🎮",
    color: "#6C5CE7",
    bg: "#F0EEFF",
    accent: "#D8D0FF",
    desc: "Fun & Learning",
  },
  {
    id: "stories",
    label: "Stories",
    emoji: "📚",
    color: "#00B894",
    bg: "#EAFAF5",
    accent: "#B2EDD8",
    desc: "Read & Listen",
  },
];

const ABCContent = ({ goBack }) => {
  const [active, setActive] = useState(null);
  const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
  const sounds = { A:"🍎 Apple", B:"🐻 Bear", C:"🐱 Cat", D:"🐶 Dog", E:"🐘 Elephant",
    F:"🐸 Frog", G:"🍇 Grape", H:"🏠 House", I:"🍦 Ice Cream", J:"🍓 Jam",
    K:"🦁 King", L:"🦁 Lion", M:"🌙 Moon", N:"🌙 Night", O:"🍊 Orange",
    P:"🐧 Penguin", Q:"👑 Queen", R:"🌈 Rainbow", S:"⭐ Star", T:"🌳 Tree",
    U:"☂️ Umbrella", V:"🎻 Violin", W:"🐋 Whale", X:"🔭 X-Ray", Y:"🌻 Yellow", Z:"🦓 Zebra" };
  return (
    <div>
      <button onClick={goBack} style={backBtn}>← Back</button>
      <h2 style={sectionTitle("🔤", "#FF6B6B")}>🔤 Learn ABC</h2>
      <p style={subText}>Tap a letter to learn its sound!</p>
      <div style={{ display:"flex", flexWrap:"wrap", gap:"10px", justifyContent:"center", padding:"10px 0 20px" }}>
        {alphabet.map(l => (
          <button key={l} onClick={() => setActive(active === l ? null : l)}
            style={{
              width: 60, height: 60, borderRadius: 16, border: "none",
              background: active === l ? "#FF6B6B" : "#FFF0F0",
              color: active === l ? "white" : "#FF6B6B",
              fontSize: 24, fontWeight: 800, cursor: "pointer",
              boxShadow: active === l ? "0 6px 0 #cc4444" : "0 4px 0 #ffaaaa",
              transform: active === l ? "translateY(2px)" : "none",
              transition: "all 0.15s",
              fontFamily: "'Fredoka One', cursive"
            }}>{l}</button>
        ))}
      </div>
      {active && (
        <div style={{
          background: "#FFF0F0", borderRadius: 24, padding: "20px",
          textAlign:"center", border: "3px solid #FF6B6B",
          animation: "popIn 0.3s ease-out"
        }}>
          <div style={{ fontSize: 60, fontFamily:"'Fredoka One', cursive", color:"#FF6B6B" }}>{active}</div>
          <div style={{ fontSize: 32 }}>{sounds[active]}</div>
          <div style={{ fontSize: 18, color:"#999", marginTop: 6 }}>
            "{active}" says <b style={{color:"#FF6B6B"}}>/{active.toLowerCase()}/</b>
          </div>
        </div>
      )}
    </div>
  );
};

const WordsContent = ({ goBack }) => {
  const words = [
    { word:"Cat", emoji:"🐱", color:"#FF9F43" }, { word:"Dog", emoji:"🐶", color:"#FF6B6B" },
    { word:"Sun", emoji:"☀️", color:"#FECA57" }, { word:"Tree", emoji:"🌳", color:"#00B894" },
    { word:"Ball", emoji:"⚽", color:"#6C5CE7" }, { word:"Fish", emoji:"🐟", color:"#0984E3" },
    { word:"Bird", emoji:"🐦", color:"#FF9FF3" }, { word:"Moon", emoji:"🌙", color:"#A29BFE" },
    { word:"Book", emoji:"📖", color:"#55EFC4" }, { word:"Star", emoji:"⭐", color:"#FFEAA7" },
    { word:"Rain", emoji:"🌧️", color:"#74B9FF" }, { word:"Cake", emoji:"🎂", color:"#FD79A8" },
  ];
  const [flipped, setFlipped] = useState({});
  return (
    <div>
      <button onClick={goBack} style={backBtn}>← Back</button>
      <h2 style={sectionTitle("📖","#FF9F43")}>📖 Words</h2>
      <p style={subText}>Tap a card to see the word!</p>
      <div style={{ display:"grid", gridTemplateColumns:"repeat(3, 1fr)", gap:12, padding:"10px 0" }}>
        {words.map((w, i) => (
          <div key={w.word} onClick={() => setFlipped(f => ({...f, [i]: !f[i]}))}
            style={{
              background: flipped[i] ? w.color : "white",
              borderRadius: 20, padding: "18px 8px",
              textAlign:"center", cursor:"pointer",
              border: `3px solid ${w.color}`,
              boxShadow: `0 6px 0 ${w.color}88`,
              transition:"all 0.25s",
              transform: flipped[i] ? "scale(1.05)" : "scale(1)"
            }}>
            <div style={{ fontSize: 36 }}>{w.emoji}</div>
            {flipped[i] && (
              <div style={{ fontSize:18, fontWeight:800, color:"white",
                fontFamily:"'Fredoka One', cursive", marginTop:6 }}>{w.word}</div>
            )}
          </div>
        ))}
      </div>
    </div>
  );
};

const GamesContent = ({ goBack }) => {
  const [score, setScore] = useState(0);
  const [current, setCurrent] = useState(0);
  const [chosen, setChosen] = useState(null);
  const questions = [
    { q:"What letter does 🍎 start with?", ans:"A", opts:["A","B","C","D"] },
    { q:"What letter does 🐻 start with?", ans:"B", opts:["A","B","C","D"] },
    { q:"What letter does 🐱 start with?", ans:"C", opts:["A","B","C","D"] },
    { q:"What letter does 🐶 start with?", ans:"D", opts:["A","B","C","D"] },
    { q:"What letter does 🐘 start with?", ans:"E", opts:["E","F","G","H"] },
  ];
  const q = questions[current % questions.length];
  const handleAns = (opt) => {
    if (chosen !== null) return;
    setChosen(opt);
    if (opt === q.ans) setScore(s => s + 1);
    setTimeout(() => { setChosen(null); setCurrent(c => c + 1); }, 1000);
  };
  return (
    <div>
      <button onClick={goBack} style={backBtn}>← Back</button>
      <h2 style={sectionTitle("🎮","#6C5CE7")}>🎮 Games</h2>
      <div style={{ background:"#F0EEFF", borderRadius:20, padding:16, marginBottom:14,
        display:"flex", justifyContent:"space-between", alignItems:"center" }}>
        <span style={{ fontFamily:"'Fredoka One', cursive", color:"#6C5CE7", fontSize:18 }}>⭐ Score: {score}</span>
        <span style={{ fontFamily:"'Fredoka One', cursive", color:"#A29BFE", fontSize:16 }}>Q {(current % questions.length)+1}/{questions.length}</span>
      </div>
      <div style={{ background:"white", borderRadius:24, padding:24, textAlign:"center",
        border:"3px solid #6C5CE7", marginBottom:16 }}>
        <div style={{ fontSize:20, fontWeight:700, color:"#2D2D2D", fontFamily:"'Fredoka One', cursive" }}>{q.q}</div>
      </div>
      <div style={{ display:"grid", gridTemplateColumns:"1fr 1fr", gap:12 }}>
        {q.opts.map(opt => {
          let bg = "white", border = "3px solid #D8D0FF", color = "#6C5CE7";
          if (chosen === opt) {
            if (opt === q.ans) { bg = "#00B894"; border = "3px solid #00B894"; color = "white"; }
            else { bg = "#FF6B6B"; border = "3px solid #FF6B6B"; color = "white"; }
          } else if (chosen !== null && opt === q.ans) {
            bg = "#00B894"; border = "3px solid #00B894"; color = "white";
          }
          return (
            <button key={opt} onClick={() => handleAns(opt)}
              style={{ padding:"18px 0", borderRadius:18, border, background:bg,
                color, fontSize:28, fontWeight:800, cursor:"pointer",
                fontFamily:"'Fredoka One', cursive",
                boxShadow:"0 6px 0 #D8D0FF", transition:"all 0.2s" }}>{opt}</button>
          );
        })}
      </div>
    </div>
  );
};

const StoriesContent = ({ goBack }) => {
  const [story, setStory] = useState(null);
  const stories = [
    { title:"The Little Rabbit", emoji:"🐰",
      color:"#00B894",
      text:"Once upon a time, a little white rabbit lived in a big green forest. Every morning, she would hop to the river to drink fresh water. One day, she found a shiny red apple under an old oak tree. 'What a wonderful surprise!' she said happily. She shared the apple with all her friends, and they all lived happily ever after. 🍎✨" },
    { title:"The Yellow Sun", emoji:"☀️", color:"#FECA57",
      text:"High up in the sky lived a cheerful yellow sun. Every day, the sun would wake up early and shine its warm light on the world below. The flowers would open their petals and say, 'Good morning, Sun!' The birds would sing beautiful songs. The sun smiled brightly and said, 'Good morning, beautiful Earth!' 🌸🐦" },
    { title:"Blue Ocean Adventure", emoji:"🌊", color:"#0984E3",
      text:"Deep in the blue ocean lived a small green fish named Finley. Finley loved to explore coral reefs and make new friends. One day, Finley met a friendly dolphin named Daisy. 'Let's swim together!' said Daisy. They swam past colorful fish and sparkly seahorses. 'The ocean is so beautiful!' said Finley. 🐬🐠" },
  ];
  if (story !== null) {
    const s = stories[story];
    return (
      <div>
        <button onClick={() => setStory(null)} style={backBtn}>← Back</button>
        <div style={{ textAlign:"center", marginBottom:16 }}>
          <div style={{ fontSize:60 }}>{s.emoji}</div>
          <h2 style={{ fontFamily:"'Fredoka One', cursive", color:s.color, fontSize:26, margin:"8px 0 4px" }}>{s.title}</h2>
        </div>
        <div style={{ background:"white", borderRadius:24, padding:24,
          border:`3px solid ${s.color}`, lineHeight:2,
          fontSize:16, color:"#444", fontFamily:"'Nunito', sans-serif" }}>
          {s.text}
        </div>
      </div>
    );
  }
  return (
    <div>
      <button onClick={goBack} style={backBtn}>← Back</button>
      <h2 style={sectionTitle("📚","#00B894")}>📚 Stories</h2>
      <p style={subText}>Choose a story to read!</p>
      <div style={{ display:"flex", flexDirection:"column", gap:14 }}>
        {stories.map((s, i) => (
          <button key={s.title} onClick={() => setStory(i)}
            style={{ background:`linear-gradient(135deg, ${s.color}22, ${s.color}44)`,
              border:`3px solid ${s.color}`, borderRadius:24, padding:"20px 16px",
              display:"flex", alignItems:"center", gap:16, cursor:"pointer",
              boxShadow:`0 6px 0 ${s.color}55`, textAlign:"left",
              transition:"all 0.2s", width:"100%" }}>
            <span style={{ fontSize:44 }}>{s.emoji}</span>
            <div>
              <div style={{ fontFamily:"'Fredoka One', cursive", fontSize:20, color:s.color }}>{s.title}</div>
              <div style={{ fontSize:13, color:"#888", marginTop:2 }}>Tap to read!</div>
            </div>
            <span style={{ marginLeft:"auto", fontSize:28 }}>▶</span>
          </button>
        ))}
      </div>
    </div>
  );
};

const backBtn = {
  background: "none", border: "none", fontSize: 16, color: "#888",
  cursor: "pointer", padding: "6px 0 14px", fontFamily: "'Nunito', sans-serif",
  fontWeight: 700, display: "block"
};
const sectionTitle = (e, c) => ({
  fontFamily: "'Fredoka One', cursive", color: c, fontSize: 28,
  margin: "0 0 4px", textAlign: "center"
});
const subText = {
  textAlign:"center", color:"#AAA", fontFamily:"'Nunito', sans-serif",
  fontSize:15, marginBottom:12
};

export default function App() {
  const [page, setPage] = useState("home");
  const [stars, setStars] = useState([]);

  useEffect(() => {
    setStars(Array.from({length:16}, (_, i) => ({
      id: i, x: Math.random()*100, y: Math.random()*100,
      size: 8 + Math.random()*14, delay: Math.random()*3, dur: 2+Math.random()*2
    })));
  }, []);

  const renderPage = () => {
    switch(page) {
      case "abc": return <ABCContent goBack={() => setPage("home")} />;
      case "words": return <WordsContent goBack={() => setPage("home")} />;
      case "games": return <GamesContent goBack={() => setPage("home")} />;
      case "stories": return <StoriesContent goBack={() => setPage("home")} />;
      default: return null;
    }
  };

  return (
    <>
      <style>{`
        @import url('https://fonts.googleapis.com/css2?family=Fredoka+One&family=Nunito:wght@400;600;700;800&display=swap');
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: #FFF8FF; }
        @keyframes float { 0%,100%{transform:translateY(0)} 50%{transform:translateY(-10px)} }
        @keyframes rabbitBounce { 0%{transform:translateY(0) rotate(-5deg)} 100%{transform:translateY(-12px) rotate(5deg)} }
        @keyframes popIn { 0%{transform:scale(0.7);opacity:0} 100%{transform:scale(1);opacity:1} }
        @keyframes twinkle { 0%,100%{opacity:0.2;transform:scale(0.8)} 50%{opacity:1;transform:scale(1.2)} }
        @keyframes slideUp { 0%{transform:translateY(30px);opacity:0} 100%{transform:translateY(0);opacity:1} }
        @keyframes rainbowShift {
          0%{background-position:0% 50%} 50%{background-position:100% 50%} 100%{background-position:0% 50%}
        }
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: #f0f0f0; border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: #ddd; border-radius: 10px; }
      `}</style>
      <div style={{
        minHeight:"100vh",
        background:"linear-gradient(160deg, #FFF0FB 0%, #EFF8FF 50%, #FFFBE0 100%)",
        fontFamily:"'Nunito', sans-serif",
        position:"relative", overflow:"hidden"
      }}>
        {/* Background stars */}
        {stars.map(s => (
          <div key={s.id} style={{
            position:"absolute", left:`${s.x}%`, top:`${s.y}%`,
            fontSize: s.size, opacity:0.35,
            animation:`twinkle ${s.dur}s ${s.delay}s ease-in-out infinite`,
            pointerEvents:"none", zIndex:0
          }}>⭐</div>
        ))}

        {/* App container */}
        <div style={{
          maxWidth:420, margin:"0 auto", padding:"0 16px 32px",
          position:"relative", zIndex:1
        }}>
          {/* Header */}
          <div style={{
            background:"linear-gradient(135deg, #FF6B9D, #FF9F43, #FECA57)",
            backgroundSize:"200% 200%",
            animation:"rainbowShift 6s ease infinite",
            borderRadius:"0 0 36px 36px",
            padding:"18px 20px 24px",
            textAlign:"center",
            boxShadow:"0 8px 32px rgba(255,107,157,0.35)",
            marginBottom:20
          }}>
            <div style={{ fontSize:13, color:"rgba(255,255,255,0.85)", letterSpacing:3, fontWeight:700 }}>
              ✨ ENGLISH LEARNING ✨
            </div>
            <h1 style={{
              fontFamily:"'Fredoka One', cursive",
              fontSize:34, color:"white", lineHeight:1.2, margin:"4px 0 0",
              textShadow:"0 3px 8px rgba(0,0,0,0.15)"
            }}>BunnyLearn!</h1>
          </div>

          {page === "home" ? (
            <>
              {/* Rabbit mascot */}
              <div style={{ textAlign:"center", marginBottom:8, animation:"slideUp 0.5s ease-out" }}>
                <RabbitCharacter mood="happy" />
                <div style={{
                  background:"white", borderRadius:20, padding:"10px 18px",
                  display:"inline-block", boxShadow:"0 4px 16px rgba(0,0,0,0.1)",
                  fontFamily:"'Fredoka One', cursive", color:"#FF6B9D", fontSize:16,
                  border:"2px solid #FFD6E7", marginTop:4, position:"relative"
                }}>
                  Hello! Let's learn English! 🌟
                  <div style={{ position:"absolute", top:-12, left:"50%", transform:"translateX(-50%)",
                    width:0, height:0, borderLeft:"10px solid transparent",
                    borderRight:"10px solid transparent", borderBottom:"12px solid white" }} />
                </div>
              </div>

              {/* Progress bar */}
              <div style={{ background:"white", borderRadius:16, padding:"12px 16px",
                marginBottom:20, boxShadow:"0 2px 12px rgba(0,0,0,0.08)" }}>
                <div style={{ display:"flex", justifyContent:"space-between", marginBottom:6 }}>
                  <span style={{ fontSize:13, fontWeight:700, color:"#888" }}>Today's Progress</span>
                  <span style={{ fontSize:13, fontWeight:800, color:"#FF6B9D" }}>🌟 42 pts</span>
                </div>
                <div style={{ background:"#F0F0F0", borderRadius:20, height:12, overflow:"hidden" }}>
                  <div style={{ width:"42%", height:"100%", borderRadius:20,
                    background:"linear-gradient(90deg, #FF6B9D, #FECA57)",
                    boxShadow:"0 0 8px rgba(255,107,157,0.5)",
                    transition:"width 1s ease" }} />
                </div>
              </div>

              {/* Section buttons */}
              <div style={{ display:"grid", gridTemplateColumns:"1fr 1fr", gap:14 }}>
                {sections.map((s, i) => (
                  <button key={s.id} onClick={() => setPage(s.id)}
                    style={{
                      background:`linear-gradient(135deg, ${s.bg}, white)`,
                      border:`3px solid ${s.color}44`,
                      borderRadius:28, padding:"22px 12px",
                      cursor:"pointer", textAlign:"center",
                      boxShadow:`0 8px 0 ${s.color}33`,
                      transition:"all 0.18s cubic-bezier(.34,1.56,.64,1)",
                      animation:`slideUp 0.4s ease-out ${i*0.08}s both`
                    }}
                    onMouseEnter={e => { e.currentTarget.style.transform = "translateY(-4px) scale(1.04)"; e.currentTarget.style.boxShadow = `0 12px 0 ${s.color}44`; }}
                    onMouseLeave={e => { e.currentTarget.style.transform = "none"; e.currentTarget.style.boxShadow = `0 8px 0 ${s.color}33`; }}
                    onTouchStart={e => { e.currentTarget.style.transform = "scale(0.96)"; e.currentTarget.style.boxShadow = `0 4px 0 ${s.color}33`; }}
                    onTouchEnd={e => { e.currentTarget.style.transform = "none"; e.currentTarget.style.boxShadow = `0 8px 0 ${s.color}33`; }}
                  >
                    <div style={{ fontSize:44, marginBottom:6 }}>{s.emoji}</div>
                    <div style={{ fontFamily:"'Fredoka One', cursive", fontSize:20, color:s.color, marginBottom:2 }}>{s.label}</div>
                    <div style={{ fontSize:12, color:"#aaa", fontWeight:600 }}>{s.desc}</div>
                  </button>
                ))}
              </div>

              {/* Daily streak */}
              <div style={{ background:"linear-gradient(135deg, #FFF0BE, #FFEAA7)",
                borderRadius:20, padding:"14px 18px", marginTop:18,
                border:"2px solid #FECA57", display:"flex", alignItems:"center", gap:12 }}>
                <div style={{ fontSize:36 }}>🔥</div>
                <div>
                  <div style={{ fontFamily:"'Fredoka One', cursive", color:"#E17055", fontSize:18 }}>5 Day Streak!</div>
                  <div style={{ fontSize:13, color:"#999" }}>Keep learning every day!</div>
                </div>
                <div style={{ marginLeft:"auto", display:"flex", gap:4 }}>
                  {["Mon","Tue","Wed","Thu","Fri"].map((d, i) => (
                    <div key={d} style={{ width:28, height:28, borderRadius:8,
                      background: i < 5 ? "#FF6B6B" : "#eee",
                      display:"flex", alignItems:"center", justifyContent:"center",
                      fontSize:9, color:"white", fontWeight:800 }}>{d}</div>
                  ))}
                </div>
              </div>
            </>
          ) : (
            <div style={{ animation:"slideUp 0.35s ease-out" }}>
              {renderPage()}
            </div>
          )}
        </div>
      </div>
    </>
  );
}
