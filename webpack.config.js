const path = require("path");
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const ExtractSVGPlugin = require("svg-sprite-loader/lib/extract-svg-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const webpack = require("webpack");
const merge = require("webpack-merge");

const autoprefixer = require("autoprefixer");

const extractCSS = new ExtractTextPlugin("css/[name].css");
const extractSVG = new ExtractSVGPlugin("images/[name].svg");

const common = {
  entry: {
    app: [
      "./web/static/css/app.scss",
      "./web/static/js/app.js"
    ],
    public: [
      "./web/static/css/public.scss",
      "./web/static/js/public/index.js"
    ],
    marketing: [
      "./web/static/css/marketing.scss",
      "./web/static/js/marketing.js"
    ]
  },

  output: {
    path: "./priv/static",
    filename: "js/[name].js"
  },

  resolve: {
    modules: [
      "node_modules",
      path.join(__dirname, "/web/static/js")
    ],
    extensions: [".js", ".jsx"]
  },

  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        loader: "babel-loader",
        options: {
          presets: [
            ["env", {
              browsers: ["last 2 versions", "safari >= 7"],
              modules: false
            }],
            "transform-object-rest-spread",
            "react"
          ]
        }
      }, {
        test: /.*\.svg$/,
        exclude: /node_modules/,
        use: extractSVG.extract({
          use: [{
            loader: "svg-sprite-loader",
            options: {
              name: "[name]-icon",
              extract: true,
              esModule: false
            }
          }, {
            loader: "svgo-loader",
            options: {
              plugins: [
                { removeTitle: true }
              ]
            }
          }]
        })
      }, {
        test: /\.scss$/,
        exclude: /node_modules/,
        use: extractCSS.extract({
          fallback: "style-loader",
          use: [{
            loader: "css-loader",
            options: {
              sourceMap: true,
              importLoaders: 1
            }
          }, {
            loader: "postcss-loader"
          }, {
            loader: "sass-loader",
            options: {
              sourceMap: true,
              includePaths: [path.join(__dirname, "/web/static/css")]
            }
          }]
        })
      }
    ]
  },

  plugins: [
    new webpack.LoaderOptionsPlugin({
      options: {
        context: path.join(__dirname, "/web/static/js"),
        postcss: [
          // require("postcss-smart-import")({
          //   from: "./web/static/css/",
          //   plugins: [ require("stylelint")() ]
          // }),
          // require("postcss-url")(),
          // require("postcss-cssnext"),
          autoprefixer()
          // require("postcss-browser-reporter")(),
          // require("postcss-reporter")()
        ]
      }
    }),
    new CopyWebpackPlugin([{
      from: { glob: "**/*", dot: false },
      context: "./web/static/assets"
    }]),
    extractCSS,
    extractSVG
  ]
};

let config;

switch (process.env.npm_lifecycle_event) {
  case "deploy":
    config = merge(common, {});
    break;
  default:
    config = merge(common, {
      module: {
        rules: [
          {
            test: /\.js$/,
            enforce: "pre",
            use: [{
              loader: "eslint-loader"
            }]
          }
        ]
      },
      devtool: "source-map"
    });
}

module.exports = config;
