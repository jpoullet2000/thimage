import 'package:thimage/config.dart';

class StableDiffusionModel {
  final String prompt;
  Map<String, dynamic> bodyData;
  StableDiffusionModel({
    required this.prompt,
  }) : bodyData = {
          "enable_hr": false,
          "denoising_strength": 0,
          "firstphase_width": 0,
          "firstphase_height": 0,
          "hr_scale": 2,
          "hr_upscaler": "string",
          "hr_second_pass_steps": 0,
          "hr_resize_x": 0,
          "hr_resize_y": 0,
          "prompt": prompt,
          "styles": ["string"],
          "seed": -1,
          "subseed": -1,
          "subseed_strength": 0,
          "seed_resize_from_h": -1,
          "seed_resize_from_w": -1,
          "sampler_name": "",
          "batch_size": 1,
          "n_iter": 1,
          "steps": 40,
          "cfg_scale": 7,
          "width": Constants.IMG_WIDTH,
          "height": Constants.IMG_HEIGHT,
          "restore_faces": false,
          "tiling": false,
          "do_not_save_samples": false,
          "do_not_save_grid": false,
          "negative_prompt": "",
          "eta": 0,
          "s_churn": 0,
          "s_tmax": 0,
          "s_tmin": 0,
          "s_noise": 1,
          "override_settings": {},
          "override_settings_restore_afterwards": true,
          "script_args": [],
          "sampler_index": "Euler",
          "script_name": "",
          "send_images": true,
          "save_images": false,
          "alwayson_scripts": {}
        };
}
