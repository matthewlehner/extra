var ExtractTextPlugin = require("extract-text-webpack-plugin");
var CopyWebpackPlugin = require("copy-webpack-plugin");
var webpack = require("webpack");

module.exports = {
  entry: {
    "js/app": "./web/static/js/app.js",
    "css/app": "./web/static/css/app.css"
  },

  output: {
    path: "./priv/static",
    filename: "[name].js"
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
          loader: "css-loader?sourceMap",
          options: { importLoaders: 1 }
        },{
          loader: "postcss-loader"
        }]
      })
    }]
  },

  plugins: [
    new webpack.LoaderOptionsPlugin({
      options: {
        context: __dirname + "/web/static/js",
        postcss: [
          require("postcss-smart-import")({
            from: "./web/static/css/",
            plugins: [ require("stylelint")() ]
          }),
          require("postcss-url")(),
          require("postcss-cssnext"),
          require("postcss-browser-reporter")(),
          require("postcss-reporter")()
        ]
      }
    }),
    new ExtractTextPlugin("css/app.css"),
    new CopyWebpackPlugin([{ from: "./web/static/assets" }])
  ],

  devtool: "source-map"
};
