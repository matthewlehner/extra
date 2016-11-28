const ExtractTextPlugin = require("extract-text-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const webpack = require("webpack");
const merge = require("webpack-merge");

let common = {
  entry: {
    "app": ["./web/static/css/app.scss", "./web/static/js/app.js"],
    "public": [
      "./web/static/css/public.scss",
      "./web/static/js/public/index.js"
    ]
  },

  output: {
    path: "./priv/static",
    filename: "js/[name].js"
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
      test: /.*\.svg$/,
      exclude: /node_modules/,
      loader: [{
        loader: "svg-sprite-loader",
        options: {
          name: "[name]-icon"
        }
      }, {
        loader: "svgo-loader",
        options: {
          plugins: [
            {removeTitle: true}
          ]
        }
      }]
    }]
  },

  plugins: [
    new webpack.LoaderOptionsPlugin({
      options: {
        context: __dirname + "/web/static/js",
        postcss: [
          // require("postcss-smart-import")({
          //   from: "./web/static/css/",
          //   plugins: [ require("stylelint")() ]
          // }),
          // require("postcss-url")(),
          // require("postcss-cssnext"),
          require('autoprefixer')({browsers: ["> 5%"]})
          // require("postcss-browser-reporter")(),
          // require("postcss-reporter")()
        ]
      }
    }),
    new CopyWebpackPlugin([{
      from: { glob: "**/*", dot: false },
      context: "./web/static/assets"
    }])
  ],

  devtool: "source-map"
};

let config;

switch(process.env.npm_lifecycle_event) {
  case "deploy":
    config = merge(common, {
      module: {
        rules: [
          {
            test: /\.scss$/,
            exclude: /node_modules/,
            loader: ExtractTextPlugin.extract({
              fallbackLoader: "style-loader",
              loader: [{
                loader: "css-loader",
                options: {
                  sourceMap: true,
                  importLoaders: 1
                }
              },
              "postcss-loader",
              {
                loader: "sass-loader",
                options: {
                  sourceMap: true,
                  includePaths: [__dirname + "/web/static/css"]
                }
              }]
            })
          }
        ]
      },
      plugins: [
        new ExtractTextPlugin("css/[name].css")
      ]
    });
    break;
  default:
    config = merge(common, {
      module: {
        rules: [{
          test: /\.scss$/,
          exclude: /node_modules/,
          loader: [
            "style-loader",
            {
              loader: "css-loader",
              options: { sourceMap: true, importLoaders: 1 }
            },
            "postcss-loader",
            {
              loader: "sass-loader",
              options: {
                sourceMap: true,
                includePaths: [__dirname + "/web/static/css"]
              }
            }
          ]
        }]
      }
    });
}

module.exports = config;
