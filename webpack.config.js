var ExtractTextPlugin = require("extract-text-webpack-plugin");
var CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = {
  entry: ["./web/static/css/app.css", "./web/static/js/app.js"],

  output: {
    path: "./priv/static",
    filename: "js/app.js"
  },

  resolve: {
    modules: [
      "node_modules",
      __dirname + "/web/static/js"
    ]
  },

  module: {
    rules: [{
      test: /\.js$/,
      exclude: /node_modules/,
      loader: "babel",
      options: {
        presets: ["es2016", ["es2015", {"modules": false}]]
      }
    }, {
      test: /\.css$/,
      loader: ExtractTextPlugin.extract({
        fallbackLoader: "style-loader",
        loader: [{
          loader: "css-loader"
        }]
      })
    }]
  },

  plugins: [
    new ExtractTextPlugin("css/app.css"),
    new CopyWebpackPlugin([{ from: "./web/static/assets" }])
  ]
};
