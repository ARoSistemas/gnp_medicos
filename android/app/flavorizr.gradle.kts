import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("qa") {
            dimension = "flavor-type"
            applicationId = "mx.com.gnp.medicos.qa"
            resValue(type = "string", name = "app_name", value = "Médicos (QA)")
        }
        create("uat") {
            dimension = "flavor-type"
            applicationId = "mx.com.gnp.medicos.uat"
            resValue(type = "string", name = "app_name", value = "Médicos (UAT)")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "mx.com.gnp.medicos"
            resValue(type = "string", name = "app_name", value = "Médicos")
        }
    }
}