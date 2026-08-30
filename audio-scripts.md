# YouthParent+ — ElevenLabs Narration Scripts

Six clips × three languages = 18 scripts. Paste each block straight into
ElevenLabs' Text to Speech tool (Multilingual v2 model). File naming
matches the `audio_url` keys already in `database/seed.sql` and
`backend/app/routers/emergency.py`, so you can drop the exported mp3s
straight in after compressing them.

## Suggested voice settings (Multilingual v2)

| Clip type | Stability | Similarity | Style | Speed |
|---|---|---|---|---|
| Grounding / breathing | 55–65% (steady, unhurried) | 75% | 0–10% (minimal) | 0.85–0.9x (slow) |
| Milestone cards | 40–50% (a bit more natural variation) | 75% | 15–25% (warm, conversational) | 1.0x |

Pick one consistent voice for all English clips, one for French, and —
if you go the voice-cloning route for Pidgin — the cloned peer-educator
voice for all Pidgin clips. Consistency matters more than any single
clip sounding perfect.

---

## 1. Grounding / De-escalation Button (~90 seconds)
File: `grounding-90s.mp3` → used as `GROUNDING_AUDIO_URL` in `emergency.py`

### English
```
Hello. I'm here with you.

Right now, in this moment, take a slow breath in... one, two, three, four.

And breathe out... one, two, three, four, five.

Good. Let's do that again. Breathe in... two, three, four.

And out... two, three, four, five.

Whatever you're feeling right now is okay. It will pass.

You are not a bad parent. You are a tired one, and that is different.

One more breath in... two, three, four.

And out... two, three, four, five.

You made it through this moment. That is enough for today.
```

### French
```
Bonjour. Je suis avec toi.

En ce moment, prends une respiration lente... un, deux, trois, quatre.

Et expire... un, deux, trois, quatre, cinq.

Bien. Recommençons. Inspire... deux, trois, quatre.

Et expire... deux, trois, quatre, cinq.

Ce que tu ressens maintenant est normal. Cela va passer.

Tu n'es pas un mauvais parent. Tu es fatigué, et ce n'est pas la même chose.

Encore une respiration... deux, trois, quatre.

Et expire... deux, trois, quatre, cinq.

Tu as traversé ce moment. C'est suffisant pour aujourd'hui.
```

### Pidgin
```
Hello. A dey here with you.

Right now, make you breathe in slow... one, two, three, four.

Now breathe out... one, two, three, four, five.

Fine. Make we do am again. Breathe in... two, three, four.

And out... two, three, four, five.

Whatever you dey feel now, e dey normal. E go pass.

You no be bad parent. You just tire, na different thing be that.

One more breath... two, three, four.

And out... two, three, four, five.

You don pass dis moment. Dat one dey enough for today.
```

---

## 2. Milestone card — Your baby is learning your voice (0–3 months)
File: `0-3-voice.mp3`

### English
```
Your baby is learning the sound of your voice. Talk to them, hum,
sing — even simple words like "I see you" or "I'm here." You don't
need the right words. Your voice alone is calming them and building
trust.
```

### French
```
Votre bébé apprend le son de votre voix. Parlez-lui, chantez,
fredonnez — même des mots simples comme « Je te vois » ou « Je suis
là ». Vous n'avez pas besoin des bons mots. Votre voix seule le
calme et construit la confiance.
```

### Pidgin
```
Ya pikin di learn ya voice sound. Talk to am, hum, sing — even
simple word like "A see you" or "A dey here." You no need di
correct word. Na ya voice alone di calm am and build trust.
```

---

## 3. Milestone card — Crying is communication (0–6 months)
File: `0-6-crying.mp3`

### English
```
When your baby cries, they are not trying to upset you. Take a
breath. Check if they're hungry, sleepy, or need a diaper change.
Then hold them close. Crying is their only way to talk to you right
now.
```

### French
```
Quand votre bébé pleure, il n'essaie pas de vous contrarier.
Respirez. Vérifiez s'il a faim, sommeil, ou besoin d'être changé.
Puis serrez-le contre vous. Pleurer est sa seule façon de vous
parler pour l'instant.
```

### Pidgin
```
When ya baby di cry, e no di try vex you. Breathe first. Check if e
hungry, sleepy, or e need change. Den hold am close. Cry na di only
way wey e get to talk to you now.
```

---

## 4. Milestone card — Babbling is the first step to talking (6–12 months)
File: `6-12-babbling.mp3`

### English
```
Your baby's babbling is the beginning of language. When they make a
sound, repeat it back to them like a little conversation. This
simple game teaches them that talking gets a response — and that
builds confidence fast.
```

### French
```
Le babillage de votre bébé est le début du langage. Quand il fait
un son, répétez-le comme une petite conversation. Ce jeu simple lui
apprend que parler obtient une réponse — et cela construit vite la
confiance.
```

### Pidgin
```
Ya baby im baby-talk na di beginning of language. When e make
sound, repeat am back like small conversation. Dis simple game di
teach am say talk di get answer — and e di build confidence fast.
```

---

## 5. Milestone card — Tantrums are a stage, not a character flaw (12–24 months)
File: `12-24-tantrum.mp3`

### English
```
When your toddler has a tantrum, get down to their eye level. Stay
calm, and name what they're feeling: "You are angry." Don't try to
teach a lesson yet — discipline works much better once everyone is
calm again.
```

### French
```
Quand votre enfant fait une crise, mettez-vous à sa hauteur. Restez
calme et nommez ce qu'il ressent : « Tu es fâché ». N'essayez pas
encore de faire la leçon — la discipline fonctionne bien mieux une
fois que tout le monde est calme.
```

### Pidgin
```
When ya small pikin di tantrum, kneel down for im level. Stay calm,
call di feeling: "You dey vex." No try teach lesson now — discipline
di work well well once everybody don calm.
```

---

## 6. Milestone card — Praise the effort, not just the result (24–36 months)
File: `24-36-praise.mp3`

### English
```
Try praising the effort, not just the result. "You tried so hard!"
builds more confidence in your child than any punishment ever
could. Praise often, correct gently, and watch how they start to
trust themselves.
```

### French
```
Essayez de féliciter l'effort, pas seulement le résultat. « Tu as
fait de ton mieux ! » construit plus de confiance chez votre enfant
que n'importe quelle punition. Félicitez souvent, corrigez
doucement, et voyez comment il commence à se faire confiance.
```

### Pidgin
```
Try praise di effort, no be only di result. "You try well well!" di
build confidence for ya pikin pass any kind beating. Praise am
often, correct am softly, and watch how e go start trust imself.
```

---

## After exporting from ElevenLabs

```bash
# Compress each clip to fit the <500KB budget from the deck
ffmpeg -i grounding-90s-raw.mp3 -b:a 64k -ac 1 -ar 22050 grounding-90s.mp3

# Repeat for each file, then upload the whole batch to a public
# Supabase Storage bucket (Storage → New bucket → "audio" → Public).
```

Then paste the resulting public URLs into:
- `database/seed.sql` — the `audio_url` jsonb column for each milestone card
- `backend/app/routers/emergency.py` — `GROUNDING_AUDIO_URL`
