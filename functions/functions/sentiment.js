const functions = require("firebase-functions");
const aposToLexForm = require("apos-to-lex-form");
const natural = require("natural");
const SpellCorrector = require("spelling-corrector");
const stopword = require("stopword");

var tokenizer = new natural.WordTokenizer();
var spellCorrector = new SpellCorrector();
spellCorrector.loadDictionary();
const analyzer = new natural.SentimentAnalyzer(
  "English",
  natural.PorterStemmer,
  "afinn"
);

exports.sentiment = functions.https.onRequest((req, res) => {
  const str = req.body.data;

  if (!str.trim()) {
    return 0;
  }

  const lexed = aposToLexForm(str)
    .toLowerCase()
    .replace(/[^a-zA-Z\s]+/g, "");

  const tokenized = tokenizer.tokenize(lexed);

  const fixedSpelling = tokenized.map((word) => spellCorrector.correct(word));

  const stopWordsRemoved = stopword.removeStopwords(fixedSpelling);

  const analyzed = analyzer.getSentiment(stopWordsRemoved);

  if (analyzed >= 1) return res.send({ sentiment: 1,score: analyzed}); // positive
  if (analyzed === 0) return res.send({ sentiment: 0 ,score: analyzed}); // neutral
  return res.send({sentiment: -1,score: analyzed}); // negative

  
});
