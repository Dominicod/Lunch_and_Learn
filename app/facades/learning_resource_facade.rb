# frozen_string_literal: true

class LearningResourceFacade # rubocop:todo Style/Documentation
  def self.create_learning_resource(query)
    images_obj_arr = ImageFacade.create_images(query)
    video_obj = VideoFacade.create_video(query)

    LearningResource.new(images_obj_arr, video_obj, query)
  end
end
